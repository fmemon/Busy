//
//  GameOverScene.mm
//  Busy
//
//  Created by Saida Memon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameOverScene.h"
#import "Busy.h"

@implementation GameOverScene

+(id) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	GameOverScene *layer = [GameOverScene node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}


-(id) init
{
	if( (self=[super init] )) {
        
        /*   CCSprite *sprite2 = [CCSprite spriteWithFile:@"u13BMineHS.png"];
         
         sprite2.anchorPoint = CGPointZero;
         [self addChild:sprite2 z:-11];
         
         //initialize data
         W1 = @"HighScorer";
         W2 = @"HighScorer";
         W3 = @"HighScorer";
         H1 = 0;
         H2 = 0;
         H3 = 0;
         newHS = 0;
         newWinner = @"HighScorer";
         muted = FALSE;
         
         [self restoreData];
         [self setLabels];
         
         // NSLog(@"After Restore: W1: %@  W2: %@  W3: %@  newWinner: %@", W1, W2, W3, newWinner);
         
         if (newHS >= H1 || newHS >= H2 || newHS >= H3) {
         myAlertView = [[UIAlertView alloc] initWithTitle:@"New HighScorer" message:@"Congratulations." delegate:self cancelButtonTitle:@"Add" otherButtonTitles:@"Cancel", nil];
         myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 30.0, 260.0, 25.0)];
         [myTextField setBackgroundColor:[UIColor whiteColor]];
         [myTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
         [myTextField setTextAlignment:UITextAlignmentCenter];
         myTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
         if ([newWinner isEqualToString:@"HighScorer"]) { 
         [myTextField setPlaceholder:@"Enter HighScorer Name"];
         }
         else {
         [myTextField setText:[NSString stringWithFormat:@"%@", newWinner]];
         }
         
         //[myTextField setText:[NSString stringWithFormat:@"%@", newWinner]];
         
         [myAlertView addSubview:myTextField];
         [myAlertView show];
         }        
         
         tapLabel = [CCLabelTTF labelWithString:@"Tap to Restart" fontName:@"Marker Felt" fontSize:35];
         tapLabel.position = ccp(249, 65.0f);    
         tapLabel.color = ccBLUE;
         [self addChild: tapLabel];
         
         // Enable touches
         CGSize screenSize = [CCDirector sharedDirector].winSize;
         
         [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
         //Pause Toggle can not sure frame cache for sprites!!!!!
         CCMenuItemSprite *playItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"newPauseON.png"]
         selectedSprite:[CCSprite spriteWithFile:@"newPauseONSelect.png"]];
         
         CCMenuItemSprite *pauseItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"newPauseOFF.png"]
         selectedSprite:[CCSprite spriteWithFile:@"newPauseOFFSelect.png"]];
         CCMenuItemToggle *pause;
         if (!muted)  {
         pause = [CCMenuItemToggle itemWithTarget:self selector:@selector(turnOnMusic)items:playItem, pauseItem, nil];
         pause.position = ccp(screenSize.width*0.06, screenSize.height*0.90f);
         }
         else {
         pause = [CCMenuItemToggle itemWithTarget:self selector:@selector(turnOnMusic)items:pauseItem, playItem, nil];
         pause.position = ccp(screenSize.width*0.06, screenSize.height*0.90f);
         }
         
         
         //Create Menu with the items created before
         CCMenu *menu = [CCMenu menuWithItems:pause, nil];
         menu.position = CGPointZero;
         [self addChild:menu z:11];
         */ 
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        tapLabel = [CCLabelTTF labelWithString:@"All Rights Reserved 2012 info@BestWhich.com" fontName:@"Arial" fontSize:16];
		tapLabel.position = ccp(229, 15.0f);    
        tapLabel.color = ccBLUE;
		[self addChild: tapLabel];
    }
    return self; 
}


-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [[CCDirector sharedDirector] replaceScene:[Busy scene]];
    return YES;
}

- (void)dealloc {
    
	[super dealloc];
}


@end
