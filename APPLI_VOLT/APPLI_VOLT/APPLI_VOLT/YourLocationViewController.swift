import UIKit
import MapKit
import CoreLocation


class YourLocationViewController: UIViewController,CLLocationManagerDelegate {

    var manager:CLLocationManager!
    
    @IBOutlet weak var myMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        //centering the location on the map
        var latitude:CLLocationDegrees = 27.175277
        var longitude:CLLocationDegrees = 78.042128
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMap.setRegion(region, animated: true)
        
        //put mark-up on the map
        var anotation = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = "Taj Mahal"
        anotation.subtitle = "I am here!"
        myMap.addAnnotation(anotation)
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        
        var userLocation: CLLocation = locations[0] as CLLocation
        
        var latitude:CLLocationDegrees = userLocation.coordinate.latitude
        var longitude:CLLocationDegrees = userLocation.coordinate.longitude
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMap.setRegion(region, animated: true)
        
        //the manager stops when finding location
        manager.stopUpdatingLocation()
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler:{(placemarks,
            error) in
            
            if((error) != nil) {
                
                println("Error: \(error)")
                
            }else{
                
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                
                var subThoroughfare:String
                
                if (p.subThoroughfare != nil){
                    subThoroughfare = p.subThoroughfare
                }else{
                    subThoroughfare = ""
                }
                
            }
        })
        
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
