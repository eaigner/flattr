//
//  FLThingClick.m
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLThingClick.h"

#import "FLDataFetcher.h"


@interface FLThingClick ()
@property (nonatomic, copy, readwrite) NSString *thingID;
@end

@implementation FLThingClick
@synthesize thingID;

+ (FLThingClick *)methodWithConsumer:(OAConsumer *)cons accessToken:(OAToken *)token thingID:(NSString *)tid {
	return [[[FLThingClick alloc] initWithAPIVersion:kFLAPIVersionLatest
																					consumer:cons
																			 accessToken:token
																					 thingID:tid] autorelease];
}

- (id)initWithAPIVersion:(FLAPIVersion)version
								consumer:(OAConsumer *)cons
						 accessToken:(OAToken *)token
								 thingID:(NSString *)tid {
	if (self = [super initWithAPIVersion:version consumer:cons accessToken:token]) {
		self.thingID = tid;
	}
	
	return self;
}

- (void)dealloc {
	self.thingID = nil;
	[super dealloc];
}

- (NSURL *)methodEndpoint {
	return [NSURL URLWithFormat:@"https://api.flattr.com/%@/thing/click/id/%@",
					[self pathVersionPrefix],
					[self thingID]];
}

- (BOOL)invokeSynchronous {
	// Check if thing ID parameter was set
	if (thingID == nil) {
		self.error = [NSError errorWithDomain:FLAPIErrorDomainName
																		 code:-1
										 localizedDescription:@"Missing thing ID parameter"];
		
		return NO;
	}
	
	// Reset fields
	self.error = nil;
	
	// Get method endpoint and fetch data
	NSURL *endpoint = [self methodEndpoint];
	NSLog(@"endpoint: %@", [endpoint absoluteString]);
	FLDataFetcher *fetcher = [[FLDataFetcher alloc] initWithEndpoint:endpoint
																													consumer:self.consumer
																														 token:self.accessToken
																														method:@"GET"];
	
	FLResponse *response = [fetcher fetchSynchronous];
	BOOL valid = [response isValid];
	
	if (!valid) {
		NSInteger statusCode = [response.response statusCode];
		
		/*
		 * http 403 - User or thing owner account inactive
		 * http 404 - The thing could not be found
		 */
		if (response.error) {
			self.error = response.error;
		}
		else if (statusCode == 403) {
			self.error = [NSError errorWithDomain:FLAPIErrorDomainName
																			 code:statusCode
											 localizedDescription:@"The users or thing owners account is inactive"];
		}
		else if (statusCode == 404) {
			self.error = [NSError errorWithDomain:FLAPIErrorDomainName
																			 code:statusCode
											 localizedDescription:@"The thing could not be found"];
		}
		else if (statusCode >= 400) {
			NSString *desc = [NSString stringWithFormat:
												@"API returned unknown status code (body: %@)",
												response.UTF8Body];
			
			self.error = [NSError errorWithDomain:FLAPIErrorDomainName
																			 code:statusCode
											 localizedDescription:desc];
		}
	}
	
	[fetcher release];
	
	return valid;
}

@end
