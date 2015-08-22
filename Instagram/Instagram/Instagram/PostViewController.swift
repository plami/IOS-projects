import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert (title:String, error: String){
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    var photoSelected:Bool = false
    
    @IBAction func logout(sender: AnyObject) {
        
        PFUser.logOut()
        
        self.performSegueWithIdentifier("logoutUser", sender: self)
        
    }
    @IBOutlet weak var imageToPost: UIImageView!
    
    @IBOutlet weak var shareText: UITextField!
    
    @IBAction func chooseImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func postImage(sender: AnyObject) {
        
        var error = ""
        
        if photoSelected == false {
            
            error = "Please select an image"
            
        } else if shareText == "" {
            
            error = "Please enter a message"
        }
        
        if error != "" {
            
            displayAlert("Cannot post image", error: error)
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var post = PFObject(className:"Post")
            post["Title"] = shareText.text
            post["Username"] = PFUser.currentUser().username
            
            post.saveInBackgroundWithBlock({ (success: Bool!, error: NSError!) -> Void in
                
                if success == false {
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.displayAlert("Could not post Image", error: "Please try again later")
                    
                } else {
                    
                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
                    
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    
                    post["imageFile"] = imageFile
                    
                    post.saveInBackgroundWithBlock({ (success: Bool!, error: NSError!) -> Void in
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        if success == false {
                            
                            self.displayAlert("Could not post Image", error: "Please try again later")
                            
                        } else {
                            
                            self.displayAlert("Image posted!", error: "Your image has been posted successfully!")
                            
                            self.photoSelected = 0
                            
                            self.imageToPost.image = UIImage(named: "315px-Blank_woman_placeholder.png")
                            
                            self.shareText.text = ""
                            
                            println("posted successfully")
                        }
                    })
                }
            })
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        println("Image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageToPost.image = image
        
        photoSelected = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoSelected = 0
        
        imageToPost.image = UIImage(named: "315px-Blank_woman_placeholder.png")
        
        shareText.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
