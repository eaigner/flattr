//
//  FLThingListByUser.m
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLThingListByUser.h"


@interface FLThingListByUser ()
@property (nonatomic, copy, readwrite) NSString *userID;
@end

@implementation FLThingListByUser
@synthesize userID;

+ (FLThingListByUser *)methodWithConsumer:(OAConsumer *)cons accessToken:(OAToken *)token userID:(NSString *)uid {
	return [[[FLThingListByUser alloc] initWithAPIVersion:kFLAPIVersionLatest
																							 consumer:cons
																						accessToken:token
																								 userID:uid] autorelease];
}

- (id)initWithAPIVersion:(FLAPIVersion)version
								consumer:(OAConsumer *)cons
						 accessToken:(OAToken *)token
									userID:(NSString *)uid {
	if (self = [super initWithAPIVersion:version consumer:cons accessToken:token]) {
		self.userID = uid;
	}
	
	return self;
}

- (void)dealloc {
	self.userID = nil;
	[super dealloc];
}

- (NSURL *)methodEndpoint {
	return [NSURL URLWithFormat:@"https://api.flattr.com/%@/thing/listbyuser/id/%@",
					[self pathVersionPrefix],
					[self userID]];
}

- (BOOL)invokeSynchronous {
	// Check if user ID parameter was set
	if (userID == nil) {
		self.error = [NSError errorWithDomain:FLAPIErrorDomainName
																		 code:-1
										 localizedDescription:@"Missing user ID parameter"];
		
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
		 * http 404 - User not found
		 */
		if (statusCode == 404) {
			self.error = [NSError errorWithDomain:FLAPIErrorDomainName
																			 code:statusCode
											 localizedDescription:@"User could not be found"];
		}
		else {
			self.error = response.error;
		}
	}
	else {
		// TODO: Parse returned XML
		NSLog(@"");
	}

	[fetcher release];
	
	return valid;
}

@end
