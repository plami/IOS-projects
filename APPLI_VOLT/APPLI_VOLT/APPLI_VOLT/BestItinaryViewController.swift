import UIKit
import MapKit

class BestItinaryViewController: UIViewController {

    @IBOutlet weak var mapItinary: MKMapView!
    
    @IBOutlet weak var searchButton: UISearchBar!
    
    @IBAction func clearButton(sender: AnyObject) {
        if searchButton.text != nil{
            searchButton.text = ""
        }
    }
    
    @IBAction func selecTypeOfMovement(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
