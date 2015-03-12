#import "cocos2d.h"

typedef enum {
    NavigationDirectionLeft = 0,
    NavigationDirectionRight = 1,
    NavigationDirectionUp = 4,
    NavigationDirectionDown = 3,
    NavigationDirectionNone = 2
}NavigationDirection;

@class TravelGameObject;

@protocol TravelObjectDelegate <NSObject>
-(BOOL) traveler:(TravelGameObject *)traveller canTravelToTile:(CGPoint)tileCoord;

@optional
-(BOOL) travellerDidTravelToTile:(CGPoint)tileCoord;
@end

@protocol TravelObjectDatasource <NSObject>
-(CGPoint) coordinateForTile:(CGPoint)tileCoord;
-(CGPoint) currentTileForTraveller:(TravelGameObject *)traveller;
@end

@interface TravelGameObject : CCNode

-(id) initWithSpriteFile:(NSString *)spriteFile;

@property (nonatomic, assign) float speed;
@property (nonatomic, assign) NavigationDirection currentDirection;
@property (nonatomic, assign) NavigationDirection futureDirection;
@property (nonatomic, weak) id<TravelObjectDelegate> delegate;
@property (nonatomic, weak) id<TravelObjectDatasource> datasource;
@property (nonatomic, strong) CCSprite *body;


-(void) startNavigating;
-(void) stopNagivating;

@end
