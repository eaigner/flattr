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
	kFLClickAccessLevelMask = 0x2,
	kFLSuperAccessLevelMask = 0x3 // all 3 combined
} FLAccessLevel;

@class OAConsumer;

@interface FLToken : OAToken {
 @private
	OAConsumer *consumer;
	BOOL authorized;
}

@property (nonatomic, retain, readonly) OAConsumer *consumer;
@property (nonatomic, assign, readonly, getter=isAuthorized) BOOL authorized;

/*
 * Token is requested synchronously for GCD async_dispatch(..)
 * convenience. Feel free to add asynchronous methods.
 */
+ (FLToken *)requestTokenForConsumer:(OAConsumer *)aConsumer error:(NSError **)err;

- (void)openAuthorizationPageRequiringAccessLevel:(FLAccessLevel)level;
- (BOOL)authorizeWithPin:(NSString *)pin;

@end
