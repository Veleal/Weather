import MapKit
import CoreLocation

class MapPresenter: NSObject {
    private(set) weak var view: MapView?
    private(set) var interactor: MapInteractor?
    
    var locationManager:CLLocationManager!

    required init(view: MapView, interactor: MapInteractor) {
        super.init()
        self.view = view
        self.interactor = interactor
        self.determineCurrentLocation()
    }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func saveLocation(location: CLLocationCoordinate2D) {
        let savingLoc = Location()
        savingLoc.id = UUID().uuidString
        savingLoc.lat = location.latitude
        savingLoc.lon = location.longitude
        interactor?.saveLocation(location: savingLoc, completion: { (success) in
            self.view?.locationSaved()
        })
    }
}

extension MapPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        self.view?.currentLocationUpdated(loc: mUserLocation)
    }
}
