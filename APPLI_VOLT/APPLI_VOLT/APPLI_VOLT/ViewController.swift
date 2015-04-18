import UIKit

class ViewController: UIViewController {
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        
//        if segue.identifier == "myLocation"{
//            
//        var alert = UIAlertController(title: "", message: "Activez « Service de Localisation » pour permettre à Plans de vous localiser.", preferredStyle: .ActionSheet)
//        
//            let enterAction = UIAlertAction(title: "Réglages", style: .Default, handler:{
//                action in
//                
//                let vc = YourLocationViewController()
//                self.presentViewController(vc, animated: true, completion: nil)
//            }
//                )
//        alert.addAction(enterAction)
//
//        
//        let defaultAction = UIAlertAction(title: "Annuler", style: .Default, handler: nil)
//        alert.addAction(defaultAction)
//        
//        presentViewController(alert, animated: true, completion: nil)
//        
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBarHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

