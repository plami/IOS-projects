#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class TouchPad;

typedef enum{
    TouchPadButtonLeft = 0,
    TouchPadButtonRight = 1,
    TouchPadButtonUp = 2,
    TouchPadButtonDown = 3,
    
}TouchPadButton;

@protocol TouchPadDelegate <NSObject>
-(void) touchPad:(TouchPad *) touchPad didTouchButton:(TouchPadButton)button;
@end


@interface TouchPad : CCNode <CCTouchOneByOneDelegate> {
   
}

@property (nonatomic, weak) id<TouchPadDelegate> delegate;


-(void) touchButton:(TouchPadButton)button;
-(void) setGlows:(BOOL)glows;

@end
