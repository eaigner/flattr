//
//  FLResponse.m
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLResponse.h"

#import "OAConsumer.h"


NSString * const FLAPIErrorDomainName = @"FLAPIErrorDomain";

@interface FLResponse ()
@property (nonatomic, retain, readwrite) NSHTTPURLResponse *response;
@property (nonatomic, retain, readwrite) OAConsumer *consumer;
@property (nonatomic, retain, readwrite) NSData *responseData;
@property (nonatomic, retain, readwrite) NSError *error;
@end

@implementation FLResponse
@synthesize response;
@synthesize consumer;
@synthesize responseData;
@synthesize error;

- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)aResponse
					 consumer:(OAConsumer *)aConsumer
						 data:(NSData *)bodyData
						error:(NSError *)err {
	if (self = [super init]) {
		self.response = aResponse;
		self.consumer = aConsumer;
		self.responseData = bodyData;
		self.error = err;
		
		// Check for errors
		if (aResponse == nil || bodyData == nil || err != nil) {
			if (error == nil) {
				NSDictionary *userInfo;
				userInfo = [NSDictionary dictionaryWithObject:@"Empty response"
													   forKey:NSLocalizedDescriptionKey];
				
				self.error = [NSError errorWithDomain:FLAPIErrorDomainName
												 code:-1
											 userInfo:userInfo];
			}
		}
	}
	
	return self;
}

- (void)dealloc {
	self.response = nil;
	self.responseData = nil;
	self.consumer = nil;
	self.error = nil;
	
	[super dealloc];
}

- (BOOL)isValid {
	return (error == nil && [response statusCode] < 400);
}

@end
