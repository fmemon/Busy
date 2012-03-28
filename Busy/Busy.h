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

//#import "MusicHandler.h"

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
    
    MyContactListener *contactListener;
}

// returns a CCScene that contains the Busy as the only child
+(CCScene *) scene;

-(void)setupBoard;
-(void)createWall:(float)length where:(float)y;

@end