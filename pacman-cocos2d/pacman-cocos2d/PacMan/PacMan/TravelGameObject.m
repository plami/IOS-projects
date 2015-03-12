#import "TravelGameObject.h"

@interface TravelGameObject(){
    CGPoint _positionDesination;
}
@end

@implementation TravelGameObject

-(id)init{
    if (self = [super init]){
        _currentDirection = NavigationDirectionRight;
        _futureDirection = NavigationDirectionRight;
        _positionDesination = self.position;
        _speed = 0.0;
    }
    return self;
}

-(id) initWithSpriteFile:(NSString *)spriteFile{
    if (self = [super init]){
        _body = [CCSprite spriteWithFile:spriteFile];
        [self addChild:_body];
        _currentDirection = NavigationDirectionRight;
        _futureDirection = NavigationDirectionRight;
        [self setContentSize:CGSizeMake(_body.contentSize.width, _body.contentSize.height)];
        _positionDesination = self.position;
        _speed = 0.0;
    }
    return self;
}

-(CGPoint)candidatePositionForDirection:(NavigationDirection)direction withDelta:(ccTime)delta{
    CGPoint candidatePosition;
    float distance = delta * [self speed];
    switch (direction) {
        case NavigationDirectionDown:{
            candidatePosition = ccpAdd(self.position, CGPointMake(0, -distance));
            break;
        }
        case NavigationDirectionUp:{
            candidatePosition =  ccpAdd(self.position, CGPointMake(0, distance));
            break;
        }
        case NavigationDirectionLeft:{
            candidatePosition = ccpAdd(self.position, CGPointMake(-distance, 0));
            break;
        }
        case NavigationDirectionRight:{
            candidatePosition = ccpAdd(self.position, CGPointMake(distance, 0));
            break;
        }
        default:
            break;
    }
    return candidatePosition;
}

-(CGPoint) nextTileForDirection:(NavigationDirection)direction{
    CGPoint nextTile;
    
    switch (direction) {
        case NavigationDirectionUp:
            nextTile = ccp(0,-1);
            break;
        case NavigationDirectionDown:
            nextTile = ccp(0,1);
            break;
        case NavigationDirectionLeft:
            nextTile = ccp(-1,0);
            break;
        case NavigationDirectionRight:
            nextTile = ccp(1,0);
            break;
        case NavigationDirectionNone:
            nextTile = ccp(0,0);
            break;
        default:
            break;
    }
    CGPoint currentTile = [[self datasource] currentTileForTraveller:self];
    return ccpAdd(currentTile, nextTile);
}

-(float) move:(ccTime)delta{
    float adjustment = 0.0;
    CGPoint positionDifference = ccpSub(_positionDesination, self.position);
    float distance = delta * self.speed;
    
    CGPoint finalDisplacement = ccp(0,0);
    
    if (positionDifference.x != 0){
        if (positionDifference.x < 0){
            finalDisplacement = ccp(-distance,0);
            if (finalDisplacement.x < positionDifference.x){
                adjustment =positionDifference.x - finalDisplacement.x;
                finalDisplacement.x = positionDifference.x;
            }
        }
        else{
            finalDisplacement = ccp(distance,0);
            if (finalDisplacement.x > positionDifference.x){
                adjustment =finalDisplacement.x - positionDifference.x;
                finalDisplacement.x = positionDifference.x;
            }
        }
    }else if (positionDifference.y != 0){
        if (positionDifference.y < 0){
            finalDisplacement = ccp(0,-distance);
            if (finalDisplacement.y < positionDifference.y){
                adjustment = positionDifference.y - finalDisplacement.y;
                finalDisplacement.y = positionDifference.y;
            }
        }else{
            finalDisplacement = ccp(0,distance);
            if (finalDisplacement.y > positionDifference.y){
                adjustment =  finalDisplacement.y - positionDifference.y;
                finalDisplacement.y = positionDifference.y;
            }
        }
    }
    
    CGPoint finalPosition = ccpAdd(self.position, finalDisplacement);
    self.position = finalPosition;
    return adjustment;
}
-(void) adjustWithAmount:(float)adjustment{
    if (adjustment !=0)
    {
        if ([[self delegate] traveler:self canTravelToTile:[self nextTileForDirection:self.futureDirection]]){
            self.currentDirection = self.futureDirection;
        }
        if ([[self delegate] traveler:self canTravelToTile:[self nextTileForDirection:self.currentDirection]]){
            _positionDesination = [[self datasource] coordinateForTile:[self nextTileForDirection:self.currentDirection]];
            switch (self.currentDirection) {
                case NavigationDirectionDown:
                    self.position = ccpAdd(self.position, ccp(0,-adjustment));
                    break;
                case NavigationDirectionUp:
                    self.position = ccpAdd(self.position, ccp(0,adjustment));
                    break;
                case NavigationDirectionLeft:
                    self.position = ccpAdd(self.position, ccp(-adjustment, 0));
                    break;
                case NavigationDirectionRight:
                    self.position = ccpAdd(self.position, ccp(adjustment, 0));
                    break;
                default:
                    break;
            }
        }
    }
}

-(void) update:(ccTime)delta
{
    float adjustment = 0.0;
    if (!CGPointEqualToPoint(_positionDesination, self.position)){
        
        adjustment = [self move:delta];
        [self adjustWithAmount:adjustment];
    }else{
        CGPoint nextTile = [[self datasource] currentTileForTraveller:self];
        if ([[self delegate] traveler:self canTravelToTile:[self nextTileForDirection:self.futureDirection]]){
            nextTile = [self nextTileForDirection:self.futureDirection];
            self.currentDirection = self.futureDirection;
            _positionDesination = [[self datasource] coordinateForTile:nextTile];
            adjustment = [self move:delta];
        }
        else if ([[self delegate] traveler:self canTravelToTile:[self nextTileForDirection:self.currentDirection]]){
            nextTile = [self nextTileForDirection:self.currentDirection];
            _positionDesination = [[self datasource] coordinateForTile:nextTile];
            adjustment = [self move:delta];
        }
        else if ([[self delegate] traveler:self canTravelToTile:[[self datasource] currentTileForTraveller:self]]){
            nextTile = [[self datasource] currentTileForTraveller:self];
            _positionDesination = [[self datasource] coordinateForTile:nextTile];
            adjustment = [self move:delta];
        }
        
    }
}
-(void) setFutureDirection:(NavigationDirection)futureDirection
{
    _futureDirection = futureDirection;
    if (NavigationDirectionOppositeToNavigationDirection(self.currentDirection, futureDirection)){
        _positionDesination = self.position;
    }
}

static inline BOOL NavigationDirectionOppositeToNavigationDirection(NavigationDirection direction1, NavigationDirection direction2)
{
    return (abs(direction1 - direction2) == 1) & (direction1 != NavigationDirectionNone & direction2 != NavigationDirectionNone);
}


-(void) startNavigating{
    _positionDesination = self.position;
    [self scheduleUpdate];
}

-(void) stopNagivating{
    [self unscheduleUpdate];
}

@end
