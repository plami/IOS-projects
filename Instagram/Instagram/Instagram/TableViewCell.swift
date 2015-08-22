import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var postedImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
