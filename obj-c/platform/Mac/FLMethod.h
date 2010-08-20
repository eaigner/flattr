//
//  FLMethod.h
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


typedef enum {
	kFLAPIVersionLatest = -1,
	kFLAPIVersion0_0_1 = 0x001
} FLAPIVersion;

@class OAToken;
@class OAConsumer;

@interface FLMethod : NSObject {
 @private
	FLAPIVersion	apiVersion;
	OAToken				*accessToken;
	OAConsumer		*consumer;
	NSError				*error;
}

@property (nonatomic, assign, readonly) FLAPIVersion apiVersion;
@property (nonatomic, retain, readonly) OAToken *accessToken;
@property (nonatomic, retain, readonly) OAConsumer *consumer;
@property (nonatomic, retain) NSError *error;

- (id)initWithAPIVersion:(FLAPIVersion)version consumer:(OAConsumer *)cons accessToken:(OAToken *)token;

/*
 * Returns a path prefix for method calls specific for the current API
 * version. Currently defaults to /rest/0.0.1
 */
- (NSString *)pathVersionPrefix;

/*
 * Returns the method specific endpoint URL, including version and method
 * parameters.
 *
 * Default implementation raises exception, must be overridden in subclasses!
 */
- (NSURL *)methodEndpoint;

/*
 * Invokes API call synchronous and returns true on success. Additional
 * response parameters can be accessed in concrete subclasses with their
 * associated properties.
 *
 * Default implementation raises exception, must be overridden in subclasses!
 */
- (BOOL)invokeSynchronous;

@end
