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


@interface FLToken ()
@property (nonatomic, retain, readwrite) OAConsumer *consumer;
@end

@implementation FLToken
@synthesize consumer;

+ (FLToken *)requestTokenForConsumer:(OAConsumer *)aConsumer error:(NSError **)err {
	if (aConsumer == nil) {
		return nil;
	}
	
	// Init data fetcher for token endpoint
	NSURL *endpoint = [NSURL URLWithString:@"http://api.flattr.com/oauth/request_token"];
	FLDataFetcher *fetcher = [[FLDataFetcher alloc] initWithEndpoint:endpoint
																													consumer:aConsumer
																														 token:nil
																														method:@"POST"];
	
	// Fetch and validate reponse
	FLResponse *response = [fetcher fetchSynchronous];
	if ([response isValid]) {
		NSString *responseBody = [[NSString alloc] initWithData:response.responseData
																									 encoding:NSUTF8StringEncoding];
		
		FLToken *token = [[FLToken alloc] initWithHTTPResponseBody:responseBody];
		token.consumer = aConsumer;
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

- (BOOL)authorizeWithPin:(NSString *)pin {
	if ([pin length] <= 0) {
		return NO;
	}
	
	// Create the request manually
	NSURL *endpoint = [NSURL URLWithString:@"https://api.flattr.com/oauth/access_token"];
	OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:endpoint
																																 consumer:self.consumer
																																		token:self
																																		realm:nil
																												signatureProvider:nil];
	[request setHTTPMethod:@"POST"];
	
	// Add the verifier field
	[request setParameters:[NSArray arrayWithObject:
													[OARequestParameter requestParameterWithName:@"oauth_verifier"
																																 value:pin]]];
	
	// Initialize new data fetcher
	FLDataFetcher *fetcher = [[FLDataFetcher alloc] initWithRequest:request];
	FLResponse *response = [fetcher fetchSynchronous];
	
	BOOL isValid = [response isValid];
	if (isValid) {
		NSString *responseBody = [[NSString alloc] initWithData:response.responseData
																									 encoding:NSUTF8StringEncoding];
		
		// Copy new key and secret to self
		FLToken *token = [[FLToken alloc] initWithHTTPResponseBody:responseBody];
		self.key = token.key;
		self.secret = token.secret;
		
		[token release];
	}

	[request release];
	[fetcher release];
	
	return isValid;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"Token {%@, %@}", self.key, self.secret];
}

@end
