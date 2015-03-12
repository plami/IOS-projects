#import "WelcomeMenu.h"
#import "PacManLevelLayer.h"
#import "CCBReader.h"
#import "SimpleAudioEngine.h"

@interface WelcomeMenu(){
    ALuint _intermissionSoundId;
}
@end

@implementation WelcomeMenu

-(id) init{
    if (self = [super init])
    {
        _intermissionSoundId = [[SimpleAudioEngine sharedEngine] playEffect:@"pacman_intermission.wav"];

    }
  return self;
}


-(void) startButtonWasTapped:(id)sender{
    
    [[SimpleAudioEngine sharedEngine] stopEffect:_intermissionSoundId];
    [[CCDirector sharedDirector]  pushScene:[PacManLevelLayer scene]];

}

-(void) aboutButtonWasTapped:(id)sender{
    NSLog(@"About!");
    
}

@end
