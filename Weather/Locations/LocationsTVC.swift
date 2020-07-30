
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
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        presenter.locations.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
}

extension LocationsTVC: LocationsView {
    func reloadData() {
        refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
}
