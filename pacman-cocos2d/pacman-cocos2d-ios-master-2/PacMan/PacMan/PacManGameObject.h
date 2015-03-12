#import "TravelGameObject.h"

@class PacManGameObject;
@protocol PacmanObjectDelegate <TravelObjectDelegate>

-(void)pacmanDidDie:(PacManGameObject *)pacman;

@end

@interface PacManGameObject : TravelGameObject

@property (nonatomic, assign) int lives;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) float shield;
@property (nonatomic, weak) id<PacmanObjectDelegate> delegate;

-(void)die;




@end
