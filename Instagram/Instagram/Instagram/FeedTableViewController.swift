import UIKit
import Parse

class FeedTableViewController: UITableViewController {

    var titles = [String]()
    var usernames = [String]()
    var images = [UIImage]()
    var imageFiles = [PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var getFollowedUserQuery = PFQuery(className: "followers")
        getFollowedUserQuery.whereKey("follower", equalTo: PFUser.currentUser().username)
        getFollowedUserQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                var followedUser = ""
                
                for object in objects {
                    
                    followedUser = object["following"] as String
                    
                    var query = PFQuery(className: "Post")
                    query.whereKey("username", equalTo:followedUser)
                    query.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]!, error: NSError!) -> Void in
                        
                        if error == nil {
                            
                            println("Successfully retrieved \(objects.count) scores")
                            
                            for object in objects {
                                
                                self.titles.append(object["Title"] as String)
                                self.usernames.append(object["username"] as String)
                                self.imageFiles.append(object["imageFile"] as PFFile)
                                
                                self.tableView.reloadData()
                                
                            }
                            
                        } else {
                            
                            println(error)
                            
                        }
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return titles.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 210
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var myCell: TableViewCell = self.tableView.dequeueReusableCellWithIdentifier("myCell") as TableViewCell
        
        myCell.title.text = titles[indexPath.row]
        myCell.username.text = usernames[indexPath.row]
        
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (imageData:NSData!, error: NSError!) -> Void in
            
            if error == nil {
                
                let image = UIImage(data: imageData)
                
                myCell.postedImage.image = image
                
            }
        }
        
        myCell.sizeToFit()
        
        return myCell
    }


}
