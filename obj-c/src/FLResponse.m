//
//  FLResponse.m
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLResponse.h"


NSString * const FLAPIErrorDomainName = @"FLAPIErrorDomain";

@interface FLResponse ()
@property (nonatomic, retain, readwrite) NSHTTPURLResponse *response;
@property (nonatomic, retain, readwrite) NSData *responseData;
@property (nonatomic, retain, readwrite) NSError *error;
@end

@implementation FLResponse
@synthesize response;
@synthesize responseData;
@synthesize error;
@dynamic UTF8Body;

- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)aResponse
												 data:(NSData *)bodyData
												error:(NSError *)err {
	if (self = [super init]) {
		self.response = aResponse;
		self.responseData = bodyData;
		self.error = err;
		
		// Check for empty response
		if (aResponse == nil && err == nil) {			
			self.error = [NSError errorWithDomain:FLAPIErrorDomainName
																			 code:-1
											 localizedDescription:@"Empty response"];
		}
	}
	
	return self;
}

- (void)dealloc {
	self.response = nil;
	self.responseData = nil;
	self.error = nil;
	
	[super dealloc];
}

- (NSString *)UTF8Body {
	if (responseData) {
		NSString *body = [[NSString alloc] initWithData:responseData
																					 encoding:NSUTF8StringEncoding];
		
		return [body autorelease];
	}
	
	return nil;
}

- (BOOL)isValid {
	return (error == nil && [response statusCode] < 400);
}

@end
