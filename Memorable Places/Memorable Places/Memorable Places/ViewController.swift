import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var myMap: MKMapView!
    
    @IBAction func findMe(sender: AnyObject) {
        
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    
    }
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create new manager and set the delegate
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1{
            
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            
        }else{
            
            //centering the location on the map
        let lat = NSString(string: places[activePlace]["lat"]!).doubleValue
        let lon = NSString(string: places[activePlace]["lon"]!).doubleValue
        var latitude:CLLocationDegrees = lat
        var longitude:CLLocationDegrees = lon
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMap.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = places[activePlace]["name"]
        myMap.addAnnotation(annotation)
            
            var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
            uilpgr.minimumPressDuration = 2.0
            myMap.addGestureRecognizer(uilpgr)
        }

    }
    
    func action(gestureRecognizer:UIGestureRecognizer){
        
        var touchPoint = gestureRecognizer.locationInView(self.myMap)
        var newCoordinate = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
    
        
        var loc = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(loc, completionHandler:{(placemarks,
            error) in
            
            if((error) != nil) {
                
                println("Error: \(error)")
                
            }else{
                
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                
                var subThoroughfare:String
                var thoroughfare:String
                
                if (p.subThoroughfare != nil){
                    subThoroughfare = p.subThoroughfare
                }else{
                    subThoroughfare = ""
                }
                
                if (p.thoroughfare != nil){
                    thoroughfare = p.thoroughfare
                }else{
                    thoroughfare = ""
                }
                
                var newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = newCoordinate
                
                var title = "\(subThoroughfare)\(thoroughfare)"
                
                if title == " "{
                    
                    var date = NSDate.date()
                    title = "Added \(date)"
                }
                
                newAnnotation.title = title
                self.myMap.addAnnotation(newAnnotation)
            }
        })
        
    }

    override func viewWillDisappear(animated: Bool) {
        
            self.navigationController?.navigationBarHidden = false
    }
    
    //creates new place every time the application is updated
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

