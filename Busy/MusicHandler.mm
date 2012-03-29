//
//  MusicHandler.mm
//  Bally
//
//  Created by Saida Memon on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MusicHandler.h"

//static NSString *WATER_EFFECT = @"splash2.caf";
//static NSString *BOUNCE_EFFECT = @"boing.caf";
static NSString *WATER_EFFECT = @"break.wav";
static NSString *BOUNCE_EFFECT = @"burp.wav";
static NSString *EXIT_EFFECT = @"giggle2.wav";
static NSString *RESET_EFFECT = @"fart3.wav";

@interface MusicHandler()
+(void) playEffect:(NSString *)path;
@end


@implementation MusicHandler

+(void) preload{
	SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
	if (engine) {
		[engine preloadEffect:WATER_EFFECT];
		[engine preloadEffect:BOUNCE_EFFECT];
		[engine preloadEffect:EXIT_EFFECT];
		[engine preloadEffect:RESET_EFFECT];
	}
}

+(void) playWater{
	[MusicHandler playEffect:WATER_EFFECT];	
}
+(void) playBounce{
	[MusicHandler playEffect:BOUNCE_EFFECT];	
}

+(void) playExit{
	[MusicHandler playEffect:EXIT_EFFECT];	
}

+(void) playReset{
	[MusicHandler playEffect:RESET_EFFECT];	
}



+(void) playEffect: (NSString *) path{
	[[SimpleAudioEngine sharedEngine] playEffect:path];
}
@end
