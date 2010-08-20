//
//  FLThingListByUser.h
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLMethod.h"


@interface FLThingListByUser : FLMethod {
 @private
	NSString *userID;
	NSArray *things;
}

@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, retain, readonly) NSArray *things;

+ (FLThingListByUser *)methodWithConsumer:(OAConsumer *)cons accessToken:(OAToken *)token userID:(NSString *)uid;

- (id)initWithAPIVersion:(FLAPIVersion)version
								consumer:(OAConsumer *)cons
						 accessToken:(OAToken *)token
								 userID:(NSString *)uid;

@end
