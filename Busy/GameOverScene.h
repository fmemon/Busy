//
//  GameOverScene.h
//  Bally
//
//  Created by Saida Memon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "MyContactListener.h"

typedef enum
{
    GameOverSceneLayerTagGame =1,
} GameOverSceneLayerTags;

typedef enum 
{
    GameOverSceneNodeTagBall = 1,
    GameOverSceneNodeTagHole,
    GameOverSceneNodeTagBatch
} GameOverSceneNodeTags;

@interface GameOverScene : CCLayer {
    b2World* world;
    MyContactListener* contactListener;
    GLESDebugDraw* debugDraw;
    CCLabelTTF* tapLabel;
}

+(id) scene;

@end