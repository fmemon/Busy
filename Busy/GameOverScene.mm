//
//  GameOverScene.mm
//  Bally
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
        CCSprite *sprite2 = [CCSprite spriteWithFile:@"back.png"];
        
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
            myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 40.0, 260.0, 25.0)];
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
		tapLabel.position = ccp(140, 105.0f);    
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
      
    
        
    }
    return self; 
}

- (void)turnOnMusic {
    if ([[SimpleAudioEngine sharedEngine] mute]) {
        // This will unmute the sound
        muted = FALSE;
        // [[SimpleAudioEngine sharedEngine] setMute:0];
    }
    else {
        //This will mute the sound
        muted = TRUE;
        //[[SimpleAudioEngine sharedEngine] setMute:1];
    }
    [[SimpleAudioEngine sharedEngine] setMute:muted];    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:muted forKey:@"IsMuted"];
    [defaults synchronize];
    
    NSLog(@"GameOver saved %d", muted);
}


-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0) {
        if ([myTextField.text length] == 0) {
            newWinner = @"HighScorer";
        }
        else {
            newWinner = [NSString stringWithFormat:@"%@", myTextField.text];
        }
        [self testScore];
        [self saveData];
        [self printScores];
        
	}else if(buttonIndex == 1){
        //Cancel button
        newWinner = @"HighScorer";
    }
}

-(void)setLabels {
    winner1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"1. %@",W1] fontName:@"Marker Felt" fontSize:24];
    winner1.position = ccp(80.0f, 280.0f);
    winner1.color = ccc3(8,51,255);
    [self addChild:winner1];
    
    HS1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",H1] fontName:@"Marker Felt" fontSize:24];
    HS1.position = ccp(140.0f, 280.0f);
    HS1.color = ccc3(8,51,255);
    [self addChild:HS1];
    
    winner2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"2. %@",W2] fontName:@"Marker Felt" fontSize:24];
    winner2.position = ccp(80.0f, 240.0f);
    winner2.color = ccRED;
    [self addChild:winner2];
    
    HS2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",H2] fontName:@"Marker Felt" fontSize:24];
    HS2.position = ccp(140.0f, 240.0f);
    HS2.color = ccRED;
    [self addChild:HS2];
    
    winner3 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"3. %@",W3] fontName:@"Marker Felt" fontSize:24];
    winner3.position = ccp(80.0f, 200.0f);
    winner3.color = ccc3(189,58,212);
    [self addChild:winner3];
    
    HS3 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",H3] fontName:@"Marker Felt" fontSize:24];
    HS3.position = ccp(140.0f, 200.0f);
    HS3.color = ccc3(189,58,212);
    [self addChild:HS3];    
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
	//Terminate editing 
	[textField resignFirstResponder]; 
	return YES; 
} 

- (void)textFieldDidEndEditing:(UITextField*)textField { 
	//NSLog(@"textFieldDidEndEditing");
    /*if (textField==myText) {    
     [myText endEditing:YES]; 
     [myText removeFromSuperview];     
     }*/
} 

- (void)saveData {   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:W1 forKey:@"Winner1"];
    [defaults setObject:W2 forKey:@"Winner2"];
    [defaults setObject:W3 forKey:@"Winner3"];
    [defaults setObject:newWinner forKey:@"newWinner"];
    
    [defaults setInteger:H1 forKey:@"HS1"];
    [defaults setInteger:H2 forKey:@"HS2"];
    [defaults setInteger:H3 forKey:@"HS3"];
    
    [defaults synchronize];
}

- (void)restoreData {
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"newWinner"]) {
        newWinner = [defaults stringForKey:@"newWinner"];
    }
    if ([defaults objectForKey:@"Winner1"]) {
        W1 = [defaults stringForKey:@"Winner1"];
    }
    if ([defaults objectForKey:@"Winner2"]) {
        W2 = [defaults stringForKey:@"Winner2"];
    }
    if ([defaults objectForKey:@"Winner3"]) {
        W3 = [defaults stringForKey:@"Winner3"];
    }
    if ([defaults integerForKey:@"newHS"]) {
        newHS = [defaults integerForKey:@"newHS"];
        NSLog(@"restored teh new high score and it is %i", newHS);
    }
    if ([defaults integerForKey:@"HS1"]) {
        H1 = [defaults integerForKey:@"HS1"];
    }
    if ([defaults integerForKey:@"HS2"]) {
        H2 = [defaults integerForKey:@"HS2"];
    }
    if ([defaults integerForKey:@"HS3"]) {
        H3 = [defaults integerForKey:@"HS3"];
    }
    // NSLog(@"Is muted value BEFORE %d", muted);
    
    if ([defaults boolForKey:@"IsMuted"]) {
        muted = [defaults boolForKey:@"IsMuted"];
        [[SimpleAudioEngine sharedEngine] setMute:muted];
        NSLog(@"Ballyafter restore %d", muted);
    }
}

- (void)testScore {
    
    if (newHS >= H1) {
        H3 = H2;
        W3 = [NSString stringWithFormat:@"%@", W2];
        H2 = H1;
        W2 = [NSString stringWithFormat:@"%@", W1];
        H1 = newHS;
        W1 = [NSString stringWithFormat:@"%@", newWinner];
    }
    else if (newHS >= H2) {
        H3 = H2;
        W3 = [NSString stringWithFormat:@"%@", W2];
        H2 = newHS;
        W2 = [NSString stringWithFormat:@"%@", newWinner];
    }
    else if (newHS >= H3) {
        H3 = newHS;
        W3 = [NSString stringWithFormat:@"%@", newWinner];
    }
    else {
        //no switch over
    }
}

- (void)printScores {
    
    [winner1 setString:[NSString stringWithFormat:@"1. %@",W1]];
    [winner2 setString:[NSString stringWithFormat:@"2. %@",W2]];
    [winner3 setString:[NSString stringWithFormat:@"3. %@",W3]];
    
    [HS1 setString:[NSString stringWithFormat:@"%i",H1]];
    [HS2 setString:[NSString stringWithFormat:@"%i",H2]];
    [HS3 setString:[NSString stringWithFormat:@"%i",H3]];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [[CCDirector sharedDirector] replaceScene:[Busy scene]];
    return YES;
}


- (void)dealloc {
    [winner1 release];
    [winner2 release];
    [winner3 release];
	[HS1 release];
    [HS2 release];
    [HS3 release];
    [W1 release];
    [W2 release];
    [W3 release];
    
    [newWinner release];
    
    [tapLabel release];
    [newHSlabel release];
    [myTextField release];
    [myAlertView release];
	[super dealloc];
}

@end
