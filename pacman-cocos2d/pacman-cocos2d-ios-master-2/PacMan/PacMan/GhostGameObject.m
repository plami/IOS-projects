#import "GhostGameObject.h"

@implementation GhostGameObject
-(id)init{
    if (self = [super initWithSpriteFile:@"ghost.png"]){
        [self schedule:@selector(updateNavigationDirection) interval:1];
    }
    return self;
}

-(void) updateNavigationDirection{
    self.futureDirection = rand()%5;
    while (self.futureDirection == NavigationDirectionNone){
            self.futureDirection = arc4random()%5;
    }
}
@end
