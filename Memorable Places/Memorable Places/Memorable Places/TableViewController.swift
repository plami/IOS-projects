import UIKit

var activePlace = 0

var places = [Dictionary<String,String>()]

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if places.count == 1{
            
            places.removeAtIndex(0)
        }
        
        places.append(["name":"Taj Mahal","lat":"27.175277","lon":"78.042128"])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //this method is called every time the tableview disappears
    override func viewWillDisappear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
    }
    
    //adding place by using the seque
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "addPlace"{
            activePlace = -1
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = places[indexPath.row]["name"]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        activePlace = indexPath.row
        
        self.performSegueWithIdentifier("findPlace", sender: indexPath)
    }

}
