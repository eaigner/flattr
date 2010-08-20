//
//  FLMethod.m
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLMethod.h"

#import "FLDataFetcher.h"


@interface FLMethod ()
@property (nonatomic, assign, readwrite) FLAPIVersion apiVersion;
@property (nonatomic, retain, readwrite) OAToken *accessToken;
@property (nonatomic, retain, readwrite) OAConsumer *consumer;
@end

@implementation FLMethod
@synthesize apiVersion;
@synthesize accessToken;
@synthesize consumer;
@synthesize error;

- (id)initWithAPIVersion:(FLAPIVersion)version consumer:(OAConsumer *)cons accessToken:(OAToken *)token {
	if (self = [super init]) {
		self.apiVersion = version;
		self.accessToken = token;
		self.consumer = cons;
	}
	
	return self;
}

- (void)dealloc {
	self.accessToken = nil;
	self.consumer = nil;
	self.error = nil;
	
	[super dealloc];
}

- (NSString *)pathVersionPrefix {
	switch (apiVersion) {
		case kFLAPIVersion0_0_1:
			return @"rest/0.0.1";
		default:
			return @"rest/0.0.1";
	}
}

- (NSURL *)methodEndpoint {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (BOOL)invokeSynchronous {
	[self doesNotRecognizeSelector:_cmd];
	return NO;
}

@end
