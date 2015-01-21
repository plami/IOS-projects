#import "ViewController.h"
#import "UserInfo.h"
#import "UsersManager.h"
#import "NotificationsCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *objects;


@end

const CGFloat kHeightOfRows = 60.0;
const NSInteger kNumberOfSections = 1;

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(update:) name:@"user" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Notifications";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NotificationsCell" bundle:nil]forCellReuseIdentifier:@"NotificationsCell"];
    
    UsersManager* manager = [[UsersManager alloc] init];
    self.objects = [NSMutableArray array];
    
//        UITableView* tableView = self.view.subviews[0];
    
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }

-(void) update:(NSNotification*) note
{
//    NSLog(@"Poluchih slednoto : %@", note.userInfo[@"info"]);
    
        [self.objects addObject:note.userInfo[@"info"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
//    NSLog(@"Is it in main thread? : %hhd", [NSThread isMainThread]);
    });
}

-(void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return kNumberOfSections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;;
}

-(CGFloat)tableView:tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeightOfRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotificationsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationsCell" forIndexPath:indexPath];
    
    UserInfo* object = self.objects[indexPath.row];
    
    cell.userNameLabel.text = [object userName];
//    cell.userNameLabel.font = [UIFont fontWithName:@"Lato-Bla.ttf" size:40.0];
    cell.userNameLabel.textColor = [UIColor blueColor];
    cell.notificationTypeLabel.text = [object notificationType];
//    cell.notificationTypeLabel.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Bd.otf" size:1.0];
    cell.notificationTypeLabel.textColor = [UIColor blueColor];
    
    cell.notificationeEventLabel.text = [object notificationEvent];
    
    cell.detailsLabel.text = [object notificationDate];
    cell.detailsLabel.textColor = [UIColor grayColor];
    return cell;
}

@end
