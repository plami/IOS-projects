import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var myMap: MKMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Core Location
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

        var latitude: CLLocationDegrees = 40.748655
        var longitude: CLLocationDegrees = -73.985621
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMap.setRegion(region, animated: true)
        
        //put mark-up on the map
        var anotation = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = "Statue of Liberty"
        anotation.subtitle = "One day I'll go here ..."
        myMap.addAnnotation(anotation)
        
        //adding new location with press gesture
        
        var longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "action:")
        
        longPressGestureRecognizer.minimumPressDuration = 2.0
        myMap.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    func action(gestureRecognizer:UIGestureRecognizer){
        
        var touchPoint = gestureRecognizer.locationInView(self.myMap)
        var newCoordinate: CLLocationCoordinate2D = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
        
        //put mark-up on the map
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoordinate
        newAnotation.title = "New place"
        newAnotation.subtitle = "One day I'll go here ..."
        
        myMap.addAnnotation(newAnotation)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as CLLocation
        
        var latitude: CLLocationDegrees = userLocation.coordinate.latitude
        var longitude: CLLocationDegrees = userLocation.coordinate.longitude
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMap.setRegion(region, animated: true)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

