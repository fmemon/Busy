//
//  Busy.mm
//  Busy
//
//  Created by Saida Memon on 3/8/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "Busy.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

// enums that will be used as tags
enum {
	kTagTileMap = 1,
	kTagBatchNode = 1,
	kTagAnimation1 = 1,
};


// Busy implementation
@implementation Busy

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Busy *layer = [Busy node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
/*
 // on "init" you need to initialize your instance
 -(id) init
 {
 // always call "super" init
 // Apple recommends to re-assign "self" with the "super" return value
 if( (self=[super init])) {
 
 // enable touches
 self.isTouchEnabled = YES;
 
 // enable accelerometer
 self.isAccelerometerEnabled = YES;
 
 CGSize screenSize = [CCDirector sharedDirector].winSize;
 CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
 
 // Define the gravity vector.
 b2Vec2 gravity;
 gravity.Set(0.0f, -10.0f);
 
 // Do we want to let bodies sleep?
 // This will speed up the physics simulation
 bool doSleep = true;
 
 // Construct a world object, which will hold and simulate the rigid bodies.
 world = new b2World(gravity, doSleep);
 
 world->SetContinuousPhysics(true);
 
 // Debug Draw functions
 m_debugDraw = new GLESDebugDraw( PTM_RATIO );
 world->SetDebugDraw(m_debugDraw);
 
 uint32 flags = 0;
 flags += b2DebugDraw::e_shapeBit;
 //		flags += b2DebugDraw::e_jointBit;
 //		flags += b2DebugDraw::e_aabbBit;
 //		flags += b2DebugDraw::e_pairBit;
 //		flags += b2DebugDraw::e_centerOfMassBit;
 m_debugDraw->SetFlags(flags);		
 
 
 // Define the ground body.
 b2BodyDef groundBodyDef;
 groundBodyDef.position.Set(0, 0); // bottom-left corner
 
 // Call the body factory which allocates memory for the ground body
 // from a pool and creates the ground box shape (also from a pool).
 // The body is also added to the world.
 b2Body* groundBody = world->CreateBody(&groundBodyDef);
 
 // Define the ground box shape.
 b2PolygonShape groundBox;		
 
 // bottom
 groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(screenSize.width/PTM_RATIO,0));
 groundBody->CreateFixture(&groundBox,0);
 
 // top
 groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO));
 groundBody->CreateFixture(&groundBox,0);
 
 // left
 groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(0,0));
 groundBody->CreateFixture(&groundBox,0);
 
 // right
 groundBox.SetAsEdge(b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,0));
 groundBody->CreateFixture(&groundBox,0);
 
 
 //Set up sprite
 
 CCSpriteBatchNode *batch = [CCSpriteBatchNode batchNodeWithFile:@"blocks.png" capacity:150];
 [self addChild:batch z:0 tag:kTagBatchNode];
 
 [self addNewSpriteWithCoords:ccp(screenSize.width/2, screenSize.height/2)];
 
 CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap screen" fontName:@"Marker Felt" fontSize:32];
 [self addChild:label z:0];
 [label setColor:ccc3(0,0,255)];
 label.position = ccp( screenSize.width/2, screenSize.height-50);
 
 [self schedule: @selector(tick:)];
 }
 return self;
 }
 */

-(id)init

{
    
    if( (self=[super init])) { 
        
        // enable touches
        
        self.isTouchEnabled = YES; 
        
        // enable accelerometer
        
        self.isAccelerometerEnabled = YES; 
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height); 
        
        // Define the gravity vector.
        
        b2Vec2 gravity;
        
        gravity.Set(0.0f, -10.0f); 
        
        // Do we want to let bodies sleep?
        
        // This will speed up the physics simulation
        
        bool doSleep = true; 
        
        // Construct a world object, which will hold and simulate the rigid bodies.
        
        world = new b2World(gravity, doSleep); 
        
        world->SetContinuousPhysics(true); 
        
        // Debug Draw functions
        
        m_debugDraw = new GLESDebugDraw( PTM_RATIO );
        
        world->SetDebugDraw(m_debugDraw); 
        
        uint32 flags = 0;
        
        flags += b2DebugDraw::e_shapeBit;
        
        //  flags += b2DebugDraw::e_jointBit;
        
        //  flags += b2DebugDraw::e_aabbBit;
        
        //  flags += b2DebugDraw::e_pairBit;
        
        //  flags += b2DebugDraw::e_centerOfMassBit;
        
        m_debugDraw->SetFlags(flags);  
        
        


        ground = NULL;
        b2BodyDef bd;
        ground = world->CreateBody(&bd);
        
        
        bodyDef.type=b2_dynamicBody;
        
        // Define the static container body, which will provide the collisions at screen borders.
        b2BodyDef containerBodyDef;
        b2Body* containerBody = world->CreateBody(&containerBodyDef);
        
        // for the ground body we'll need these values
        float widthInMeters = screenSize.width / 32.0f;
        float heightInMeters = screenSize.height / 32.0f;
        b2Vec2 lowerLeftCorner = b2Vec2(0, 0);
        b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, 0);
        b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters);
        b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters);
        
        // Create the screen box' sides by using a polygon assigning each side individually.
        b2PolygonShape screenBoxShape;
        int density = 0;
        
        // left side
        screenBoxShape.SetAsEdge(upperLeftCorner, lowerLeftCorner);
        containerBody->CreateFixture(&screenBoxShape, density);
        
        // right side
        screenBoxShape.SetAsEdge(upperRightCorner, lowerRightCorner);
        containerBody->CreateFixture(&screenBoxShape, density);
        
        // bottom
        screenBoxShape.SetAsEdge(lowerLeftCorner, lowerRightCorner);
        containerBody->CreateFixture(&screenBoxShape, density);
        
        // top
        screenBoxShape.SetAsEdge(upperLeftCorner, upperRightCorner);
        containerBody->CreateFixture(&screenBoxShape, density);
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameSprites.plist"];
        CCSpriteBatchNode*  spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"GameSprites.png"];
        [self addChild:spriteSheet];
        
        
        [self setupBoard];
        [self createWall:1.3f where:8.9f];
        [self createWall:2.3f where:11.9f];
        [self createWall:4.3f where:6.9f];
        [self createWall:6.3f where:4.9f];
        [self createWall:8.3f where:2.9f];
        
        [self schedule: @selector(tick:)]; 
        
    }
    
    return self; 
    
}

-(void)setupBoard {
    
    //background
    sprite = [CCSprite spriteWithFile:@"back.png"];
    sprite.anchorPoint = CGPointZero;
    sprite.position = CGPointZero;
    [self addChild:sprite z:-11];
    
    //circle1
    sprite = [CCSprite spriteWithSpriteFrameName:@"ball.png"];
    sprite.position = ccp(480.0f/2, 50/PTM_RATIO);
    [self addChild:sprite z:1 tag:11];
    bodyDef.userData = sprite;
    bodyDef.position.Set(0.47f, 11.58f);
    ball = world->CreateBody(&bodyDef);
    circleShape.m_radius = (sprite.contentSize.width / 32.0f) * 0.5f;
    fixtureDef.shape = &circleShape;
    fixtureDef.density = 5.0f*CC_CONTENT_SCALE_FACTOR();
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 0.4f;
    ball->CreateFixture(&fixtureDef);
        
    //Hole
    sprite = [CCSprite spriteWithSpriteFrameName:@"hole.png"];
    sprite.position = ccp(480.0f/2, 50/PTM_RATIO);
    [self addChild:sprite z:1 tag:11];
    bodyDef.userData = sprite;
    bodyDef.position.Set(5.0f, 1.2f);
    bodyDef.type = b2_staticBody;
    b2Body* hole = world->CreateBody(&bodyDef);
    circleShape.m_radius = (sprite.contentSize.width / 32.0f) * 0.05f;
    fixtureDef.shape = &circleShape;
    fixtureDef.density = 1.0f*CC_CONTENT_SCALE_FACTOR();
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 0.0f;
    fixtureDef.isSensor = true;
    hole->CreateFixture(&fixtureDef);
}


-(void)createWall:(float)length where:(float)y {
    //Hole
    //sprite = [CCSprite spriteWithSpriteFrameName:@"hole.png"];
    //sprite.position = ccp(480.0f/2, 50/PTM_RATIO);
    //[self addChild:sprite z:1 tag:11];
    //bodyDef.userData = sprite;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(length, y);
    //bodyDef.angle = -0.222508f;
    b2Body* wall = world->CreateBody(&bodyDef);
    boxy.SetAsBox(3.0f, 0.35f);
    boxy.m_centroid.Set(0, 0 );

    fixtureDef.shape = &boxy;
    fixtureDef.density = 0.015000f;
    fixtureDef.friction = 0.300000f;
    fixtureDef.restitution = 0.600000f;
    fixtureDef.filter.groupIndex = int16(0);
    fixtureDef.filter.categoryBits = uint16(65535);
    fixtureDef.filter.maskBits = uint16(65535);        
    wall->CreateFixture(&boxy,0);
    
    bodyDef.position.Set( length + 6.8f, y);
    wall = world->CreateBody(&bodyDef);
    boxy.SetAsBox(2.0f, 0.35f);
    boxy.m_centroid.Set(0, 0 );
    
    fixtureDef.shape = &boxy;
    fixtureDef.density = 0.015000f;
    fixtureDef.friction = 0.300000f;
    fixtureDef.restitution = 0.600000f;
    fixtureDef.filter.groupIndex = int16(0);
    fixtureDef.filter.categoryBits = uint16(65535);
    fixtureDef.filter.maskBits = uint16(65535);        
    wall->CreateFixture(&boxy,0);

}

-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    
}


-(void) tick: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
    
	
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}	
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		//[self addNewSpriteWithCoords: location];
	}
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
	static float prevX=0, prevY=0;
	
	//#define kFilterFactor 0.05f
#define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	// accelerometer values are in "Portrait" mode. Change them to Landscape left
	// multiply the gravity by 10
	b2Vec2 gravity( -accelY * 10, accelX * 10);
	
	world->SetGravity( gravity );
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	delete world;
	world = NULL;
	
	delete m_debugDraw;
    
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
