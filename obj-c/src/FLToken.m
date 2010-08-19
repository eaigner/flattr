//
//  FLToken.m
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLToken.h"

#import "OAConsumer.h"
#import "OAMutableURLRequest.h"

#import "FLResponse.h"
#import "FLDataFetcher.h"


@implementation FLToken

+ (FLToken *)requestTokenForConsumer:(OAConsumer *)consumer error:(NSError **)err {
	if (consumer == nil) {
		return nil;
	}
	
	// Init data fetcher for token endpoint
	NSURL *endpoint = [NSURL URLWithString:@"http://api.flattr.com/oauth/request_token"];
	FLDataFetcher *fetcher = [[FLDataFetcher alloc] initWithEndpoint:endpoint
																													consumer:consumer
																														 token:nil
																														method:@"POST"];
	
	// Fetch and validate reponse
	FLResponse *response = [fetcher fetchSynchronous];
	if ([response isValid]) {
		NSString *responseBody = [[NSString alloc] initWithData:response.responseData
																									 encoding:NSUTF8StringEncoding];
		
		FLToken *token = [[FLToken alloc] initWithHTTPResponseBody:responseBody];
		
		return [token autorelease];
	}
	else {
		*err = response.error;
	}
	
	return nil;
}

- (void)openAuthorizationPageRequiringAccessLevel:(FLAccessLevel)level {
	// Build the access scope parameter. Use 'read' as default.
	NSMutableArray *scopeParams = [NSMutableArray	array];
	[scopeParams addObject:@"read"];
	
	if (level & kFLPublishAccessLevelMask == kFLPublishAccessLevelMask) {
		[scopeParams addObject:@"publish"];
	}
	if (level & kFLClickAccessLevelMask == kFLClickAccessLevelMask) {
		[scopeParams addObject:@"click"];
	}
	
	NSString *scope = [scopeParams componentsJoinedByString:@","];
	
	// Append params to authorization endpoint
	NSString *params = [NSString stringWithFormat:@"oauth_token=%@&access_scope=%@",
											self.key,
											scope];
	
	NSString *endpoint = [NSString stringWithFormat:
												@"https://api.flattr.com/oauth/authenticate?%@",
												params];
	
	// Open the auth page
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:endpoint]];
}

@end