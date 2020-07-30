import UIKit
import MapKit

class MapViewController: UIViewController {
    
    lazy var presenter = {
        return MapPresenter(view: self, interactor: MapInteractor(mapRepository: DataManager()))
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    
    var initialLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        self.mapView.addGestureRecognizer(longTapGesture)
    }
    
    @objc func longTap(sender: UIGestureRecognizer){
        print("long tap")
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)
        }
    }
    
    func addAnnotation(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(annotation)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let location = mapView.annotations.first?.coordinate else { return }
        presenter.saveLocation(location: location)
    }
}

extension MapViewController: MapView {
    func currentLocationUpdated(loc: CLLocation) {
        if initialLocation == nil {
            self.initialLocation = loc
            self.mapView.centerToLocation(loc)
        }
    }
    
    func locationSaved() {
        self.navigationController?.popViewController(animated: true)
    }
}

private extension MKMapView {
    func centerToLocation( _ location: CLLocation, regionRadius: CLLocationDistance = 1000 ) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
