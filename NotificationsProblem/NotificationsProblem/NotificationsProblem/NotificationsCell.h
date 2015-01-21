#import <UIKit/UIKit.h>

@interface NotificationsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationeEventLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@end
