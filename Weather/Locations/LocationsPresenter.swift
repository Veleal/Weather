
class LocationsPresenter {
    private(set) var view: LocationsView?
    private(set) var interactor: LocationsInteractor?
    
    var locations: [Location] = []
    
    required init(view: LocationsView, interactor: LocationsInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func getLocations() {
        interactor?.loadLocations{(locations) in
            self.locations = locations
            view?.reloadData()
        }
    }
    
    func getWeathers() {
        locations.forEach{interactor?.loadWeather(location: $0, completion: { (succsess) in
            view?.reloadData()
        })}
    }
}
