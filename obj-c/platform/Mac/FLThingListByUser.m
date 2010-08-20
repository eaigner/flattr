//
//  FLThingListByUser.m
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLThingListByUser.h"

#import "TouchXML.h"

#import "FLDataFetcher.h"
#import "FLThing.h"
#import "FLThing+Writeable.h"


@interface FLThingListByUser ()
@property (nonatomic, copy, readwrite) NSString *userID;
@property (nonatomic, retain, readwrite) NSArray *things;

@end


@implementation FLThingListByUser
@synthesize userID;
@synthesize things;

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
	self.things = nil;
	
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
	self.things = nil;
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
		// Parse returned XML
		NSError *xmlErr = noErr;
		NSLog(@"BODY:\n\n%@", response.UTF8Body);
		CXMLDocument *doc = [[CXMLDocument alloc] initWithData:response.responseData
																									 options:0
																										 error:&xmlErr];
		
		if (xmlErr != noErr || doc == nil) {
			self.error = [NSError errorWithDomain:FLAPIErrorDomainName
																			 code:0x100
											 localizedDescription:@"Could not parse XML"];
			valid = NO;
		}
		else {
			/*
			 * Sample XML
			 *
			 * <?xml version="1.0" encoding="utf-8"?>
			 * <flattr>
			 *		<version>0.0.1</version>
			 *		<thing>
			 *			<id>bf12b55dc73d89835fff9696b6cc3883</id>
			 *			<created>1276784931</created>
			 *			<language>sv_SE</language>
			 *			<url>http://www.kontilint.se/kontakt</url>
			 *			<title>Kontakta Kontilint</title>
			 *			<story><![CDATA[Kontakta Kontilint]]></story>
			 *			<clicks>0</clicks>
			 *			<user>
			 *				<id>244</id>
			 *				<username>Bomelin</username>
			 *			</user>
			 *			<tags>
			 *				<tag>asd</tag>
			 *				<tag>fgh</tag>
			 *				<tag>ert</tag>
			 *			</tags>
			 *			<category>
			 *				<id>text</id>
			 *				<name>Written text</name>
			 *			</category>
			 *			<status>owner</status>
			 *		</thing>
			 *		<thing>
			 *			...
			 *		</thing>
			 * </flattr>
			 */
			
			NSLog(@"XML:\n\n%@", [doc stringValue]);
			
			NSArray *thingNodes = [doc nodesForXPath:@"//thing" error:nil];
			NSMutableArray *collect = [NSMutableArray arrayWithCapacity:[thingNodes count]];
			
			for (CXMLElement *node in thingNodes) {
				FLThing *thing = [[FLThing alloc] init];
				thing.id = [node stringForXPath:@"//id"];
				thing.created = [node integerForXPath:@"//created"];
				thing.language = [node stringForXPath:@"//language"];
				thing.URL = [node URLForXPath:@"//url"];
				thing.title = [node stringForXPath:@"//title"];
				thing.clicks = [node integerForXPath:@"//clicks"];
				thing.userID = [node integerForXPath:@"//user/id"];
				thing.userName = [node stringForXPath:@"//user/username"];
				thing.tags = [node stringArrayForNodesAtXPath:@"//tags/tag"];
				thing.categoryID = [node stringForXPath:@"//category/id"];
				thing.categoryName = [node stringForXPath:@"//category/name"];
				thing.status = [node stringForXPath:@"//status"];
				
				[collect addObject:thing];
				[thing release];
			}
			
			self.things = [NSArray arrayWithArray:collect];
		}
	}

	[fetcher release];
	
	return valid;
}

@end
