//
//  FLToken.h
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "OAToken.h"


typedef enum {
	kFLReadAccessLevelMask = 0x0, // we require at least read level so we start at 0
	kFLPublishAccessLevelMask = 0x1,
	kFLClickAccessLevelMask = 0x2
} FLAccessLevel;

@class OAConsumer;

@interface FLToken : OAToken {

}

/*
 * Token is requested synchronously for GCD async_dispatch(..)
 * convenience. Feel free to add asynchronous methods.
 */
+ (FLToken *)requestTokenForConsumer:(OAConsumer *)consumer error:(NSError **)err;

- (void)openAuthorizationPageRequiringAccessLevel:(FLAccessLevel)level;

@end
