import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var item: UITextField!
    
    
    @IBAction func addItem(sender: AnyObject) {
        
        toDoList.append(item.text)
        item.text = ""
        
    NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

