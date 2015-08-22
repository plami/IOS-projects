import UIKit
import Parse
import Bolts

class ViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    var signupActive = true
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert (title:String, error: String){
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var alreadyRegistered: UILabel!
    
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signUpToggleButton: UIButton!
    
    @IBAction func toggleSignUp(sender: AnyObject) {
        
        if signupActive == true {
            
            signupActive = false
            signUpLabel.text = "Use the form below to log in"
            signUpButton.setTitle("Log In", forState: UIControlState.Normal)
            alreadyRegistered.text = "Not Registered"
            signUpToggleButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
        } else {
            
            signupActive = true
            signUpLabel.text = "Use the form below to sign up"
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            alreadyRegistered.text = "Already Registered"
            signUpToggleButton.setTitle("Log In", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        var error = ""
        
        if username.text == "" || password.text == "" {
            error = "Please enter valid username and password!"
        }
        if error != "" {
            displayAlert("You cannot sign up!", error: error)
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if signupActive == true {
                
                var user = PFUser()
                user.username = username.text
                user.password = password.text
                
                user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, signupError: NSError!) -> Void in
                
                 self.activityIndicator.stopAnimating()
                 UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                   if signupError == nil {
                    
                        self.performSegueWithIdentifier("jumpToUserTable", sender: self)
                    
                        println("signed up")
                    
                   } else {
                    
                     if let errorString = signupError.userInfo?["error"] as? NSString {
                        
                        error = errorString
                        
                     } else {
                        
                        error = "Please try again later."
                     }
                    
                     self.displayAlert("Could not sing up!", error: error)
                   }
                }
                
            } else {
                
                PFUser.logInWithUsernameInBackground(username.text, password: password.text) {
                    (user: PFUser!, signupError: NSError!) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signupError == nil {
                        
                        self.performSegueWithIdentifier("jumpToUserTable", sender: self)
                        
                        println("logged in")
                        
                    } else {
                        
                        if let errorString = signupError.userInfo?["error"] as? NSString {
                            
                            error = errorString
                        }else{
                            
                            error = "Please try again later."
                        }
                        
                        self.displayAlert("Could not log in!", error: error)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser() != nil{
            self.performSegueWithIdentifier("jumpToUserTable", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
    }
}

