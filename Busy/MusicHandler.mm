//
//  MusicHandler.mm
//  Bally
//
//  Created by Saida Memon on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MusicHandler.h"

static NSString *WATER_EFFECT = @"splash2.caf";
static NSString *BOUNCE_EFFECT = @"boing.caf";


@interface MusicHandler()
+(void) playEffect:(NSString *)path;
@end


@implementation MusicHandler

+(void) preload{
	SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
	if (engine) {
		[engine preloadEffect:WATER_EFFECT];
		[engine preloadEffect:BOUNCE_EFFECT];
	}
}

+(void) playWater{
	[MusicHandler playEffect:WATER_EFFECT];	
}
+(void) playBounce{
	[MusicHandler playEffect:BOUNCE_EFFECT];	
}


+(void) playEffect: (NSString *) path{
	[[SimpleAudioEngine sharedEngine] playEffect:path];
}
@end
