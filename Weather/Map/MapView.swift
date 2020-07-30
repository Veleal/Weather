import CoreLocation

protocol MapView: class {
    func locationSaved()
    func currentLocationUpdated(loc: CLLocation)
}
