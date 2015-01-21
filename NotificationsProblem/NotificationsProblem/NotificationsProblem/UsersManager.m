#import "UsersManager.h"
#import "UserInfo.h"

@implementation UsersManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youlocalapp.com/api/notifications/load/?largeScreen&token=f2908658dc92d32a491d2e5b30aad86e"]];
    
    NSURLSessionDataTask* downloadJSONTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",string);
        
        NSError* mistake = nil;
        ;
        NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&mistake];
        
        if (mistake != nil) {
            NSLog(@"Error : %@", [mistake localizedDescription]);
        }
        else{
//            NSLog(@"%@",jsonDict);
            NSArray* notifications = [jsonDict objectForKey:@"notifications"];
            
            for (NSDictionary* notification in notifications) {
                
                UserInfo* info = [[UserInfo alloc] init];
                info.userName = notification[@"fullname"];
                info.notificationType = notification[@"notificationTypeText"];
                info.notificationEvent = notification[@"notificationEvent"];
                info.notificationDate = notification[@"notificationDate"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"user" object:self userInfo:[NSDictionary dictionaryWithObjects:@[info] forKeys:@[@"info"]]];
           }
        }
        
    }];
        [downloadJSONTask resume];
    }
    return self;
}

@end
