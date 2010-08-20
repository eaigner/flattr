//
//  FLDataFetcher.m
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLDataFetcher.h"

#import "OAToken.h"
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"


@implementation FLDataFetcher

- (id)initWithEndpoint:(NSURL *)endpoint consumer:(OAConsumer *)consumer token:(OAToken *)token method:(NSString *)meth {
	OAMutableURLRequest *req = [[OAMutableURLRequest alloc] initWithURL:endpoint
																														 consumer:consumer
																																token:token
																																realm:nil
																										signatureProvider:nil];
	[req setHTTPMethod:meth];
	
	return [self initWithRequest:[req autorelease]];
}

- (id)initWithRequest:(OAMutableURLRequest *)req {
	if (self = [super init]) {
		request_ = [req retain];
	}
	
	return self;
}

- (void)dealloc {
	[request_ release];
	[super dealloc];
}

- (FLResponse *)fetchSynchronous {
	// Prepare request
	[request_ prepare];
	
	// Send request
	NSError *err = noErr;
	NSHTTPURLResponse *response = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request_
																							 returningResponse:&response
																													 error:&err];
	
	// Init response object
	FLResponse *responseObject = [[FLResponse alloc] initWithHTTPURLResponse:response
																																			data:responseData
																																		 error:err];
	
	return [responseObject autorelease];  
}

@end
