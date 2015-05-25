import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var guess: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func isItPrimeButton(sender: AnyObject) {
        
        var number = guess.text.toInt()
        
        if number != nil{
            
        var isPrime = true
            
            if number == 1{
                
                isPrime = false;
            }
            
            if number != 1 && number != 2{
                
                for var i = 2; i < number; i++ {
                        
                    if number! % i == 0{
                        
                        isPrime = false
                    }
                }
                }
            
            if isPrime == true{
                
                resultLabel.text = "The \(number!) is prime!"
                
            }else{
                
                resultLabel.text = "The \(number!) is not prime!"
            }
        }else{
            
            resultLabel.text = "Please enter number!"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

