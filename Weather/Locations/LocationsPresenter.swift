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
        interactor?.loadLocations{(locations) in
            self.locations = locations
            getWeathers()
            view?.reloadData()
        }
    }
    
    func deleteLocation(id: String) {
        interactor?.deleteLocations(locationId: id, completion: {(locations) in
               self.locations = locations
               getWeathers()             
           })
       }
    
    private func getWeathers() {
        locations.forEach{interactor?.loadWeather(location: $0, completion: { (succsess) in
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        })}
    }
}
