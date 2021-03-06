
import UIKit

class LocationsTVC: UITableViewController {
    
    lazy var presenter = {
        return LocationsPresenter(view: self, interactor: LocationsInteractor(dataRepository: DataManager(), weatherRepository: NetworkManager()))
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getWeatherData()
    }
    
    private func setupUI(){
        setupRefreshControll()
    }
    
    private func setupRefreshControll() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(Self.getWeatherData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    @objc private func getWeatherData() {
        refreshControl?.beginRefreshing()
        presenter.getLocations()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WeatherDetailVC, let info = sender as? StationInfo {
            vc.stationInfo = info
        }
    }
}

// MARK: - UITableViewDataSource

extension LocationsTVC {    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationCell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        let location = presenter.locations[indexPath.row]
        locationCell.setCell(location: location)
        
        return locationCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let info = presenter.locations[indexPath.row].stationInfo else { return }
        self.performSegue(withIdentifier: "toDetatil", sender: info)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteLocation(id: presenter.locations[indexPath.row].id)
        }
    }
}

extension LocationsTVC: LocationsView {
    //have only 20 minutes for adding error handler=) so it is suuuper simple. The goal was to show status for exact location, but havn't time to implement this.
    func showError(error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let close = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(close)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reloadData() {
        refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
}
