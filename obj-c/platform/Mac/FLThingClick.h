//
//  FLThingClick.h
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLMethod.h"


@interface FLThingClick : FLMethod {
 @private
	NSString *thingID;
}

@property (nonatomic, copy, readonly) NSString *thingID;

/*
 * The thing ID must not be confused with the integer id. It is a hash value
 * that you can retrieve with other API functions (such as thing/listbyuser)
 */
+ (FLThingClick *)methodWithConsumer:(OAConsumer *)cons accessToken:(OAToken *)token thingID:(NSString *)tid;

- (id)initWithAPIVersion:(FLAPIVersion)version
								consumer:(OAConsumer *)cons
						 accessToken:(OAToken *)token
								 thingID:(NSString *)tid;

@end
