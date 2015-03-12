#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TouchPad.h"
#import "PacManGameObject.h"
#import "GhostGameObject.h"
#import "CCTMXLayer+TileAdditions.h"

@interface PacManLevelLayer : CCLayer <TouchPadDelegate, TravelObjectDelegate, TravelObjectDatasource, PacmanObjectDelegate> {
    
}

+(CCScene *) scene;


@end
