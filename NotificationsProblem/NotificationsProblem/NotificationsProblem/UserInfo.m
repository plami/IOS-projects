#import "UserInfo.h"

@interface UserInfo ()


@end

@implementation UserInfo


-(NSString *)description {
    return [NSString stringWithFormat:@"User : %@ Notification type : %@ Notification event : %@ Notification date : %@ \n", self.userName, self.notificationType, self.notificationEvent, self.notificationDate];
}


@end
