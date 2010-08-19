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

#import "FLResponse.h"


@implementation FLDataFetcher

- (id)initWithEndpoint:(NSURL *)endpoint consumer:(OAConsumer *)consumer
				 token:(OAToken *)token method:(NSString *)httpMethod {
	if (self = [super init]) {
		endpoint_ = [endpoint retain];
		consumer_ = [consumer retain];
		token_ = [token retain];
		method_ = [httpMethod copy];
	}
	
	return self;
}

- (void)dealloc {
	[endpoint_ release];
	[consumer_ release];
	[token_ release];
	[method_ release];
	
	[super dealloc];
}

- (FLResponse *)fetchSynchronous {
	NSData *responseData;
	OAMutableURLRequest *request;
	
	request = [[OAMutableURLRequest alloc] initWithURL:endpoint_
											  consumer:consumer_
												 token:token_
												 realm:nil
									 signatureProvider:nil];
	
    [request setHTTPMethod:method_];
	[request prepare];
	
	// Send request
	NSError *err = noErr;
	NSHTTPURLResponse *response = nil;
	responseData = [NSURLConnection sendSynchronousRequest:request
										 returningResponse:&response
													 error:&err];
	
	// Init response object
	FLResponse *responseObject = [[FLResponse alloc] initWithHTTPURLResponse:response
																	consumer:consumer_
																		data:responseData
																	   error:err];
	
	[request release];
	
	return [responseObject autorelease];  
}

@end
