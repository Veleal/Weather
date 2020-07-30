import Foundation

class LocationsPresenter {
    private(set) weak var view: LocationsView?
    private(set) var interactor: LocationsInteractor?
    
    var locations: [Location] = []
    
    required init(view: LocationsView, interactor: LocationsInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func getLocations() {
        interactor?.loadLocations{[weak self] (locations) in
            self?.locations = locations
            self?.getWeathers()
            self?.view?.reloadData()
        }
    }
    
    func deleteLocation(id: String) {
        interactor?.deleteLocations(locationId: id, completion: {[weak self](locations) in
            self?.locations = locations
            self?.getWeathers()
        })
    }
    
    private func getWeathers() {
        locations.forEach{interactor?.loadWeather(location: $0, completion: { [weak self] (succsess, error)  in
            if error == nil {
                DispatchQueue.main.async {
                    self?.view?.reloadData()
                }
            }else {
                self?.view?.showError(error: error!)
            }
        })}
    }
}
