//
//  Busy.h
//  Busy
//
//  Created by Saida Memon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "MyContactListener.h"
#import "MusicHandler.h"

// Busy
@interface Busy : CCLayer
{
	b2World* world;
	GLESDebugDraw *m_debugDraw;
    
    b2BodyDef bodyDef,bodyDef1;
    b2Body* ground;
    b2Vec2 initVel;
    b2CircleShape circleShape;
    b2Vec2 pos;
    b2FixtureDef fixtureDef;        
    b2PolygonShape boxy;
    b2Body* ball;
    b2Body* hole;
    CCSprite *sprite;
    CCSprite *ballSprite;
    
    MyContactListener *contactListener;
    CCTexture2D *texture;
    int score;
    int highscore;
    CCLabelTTF *highscoreLabel;
    CCLabelTTF *scoreLabel;

    CCMenuItemToggle *pause;
    
    BOOL muted;
    BOOL stopWater;
    b2Fixture *_leftFixture;
    b2Fixture *_rightFixture;
    b2Fixture * _ballFixture;
    NSArray *walls;
    
    BOOL level1;
    BOOL level2;
    BOOL level3;
    BOOL level4;
    BOOL level5;
    BOOL level6;
    
    CCParticleExplosion *myEmitter;

}

// returns a CCScene that contains the Busy as the only child
+(CCScene *) scene;

-(void)setupBoard;
-(void)createWall:(float)length where:(float)y;
- (CCAction*)createBlinkAnim:(BOOL)isTarget;
- (CCAction*)createEyesBlinkAnim:(BOOL)isTarget;
- (void)turnOnMusic;
- (void)restoreData;
- (void)updateScore;
- (void)saveData;
- (void)scored:(int)scorVal;
-(void)callEmitter;


@end