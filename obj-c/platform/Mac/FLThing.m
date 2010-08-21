//
//  FLThing.m
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLThing.h"


@implementation FLThing
@synthesize id;
@synthesize created;
@synthesize language;
@synthesize URL;
@synthesize title;
@synthesize story;
@synthesize clicks;
@synthesize userID;
@synthesize userName;
@synthesize tags;
@synthesize categoryID;
@synthesize categoryName;
@synthesize status;

- (void)dealloc {
	self.id = nil;
	self.language = nil;
	self.URL = nil;
	self.title = nil;
	self.story = nil;
	self.userName = nil;
	self.tags = nil;
	self.categoryID = nil;
	self.categoryName = nil;
	self.status = nil;
	
	[super dealloc];
}

- (NSString *)description {
	return [[NSDictionary dictionaryWithObjectsAndKeys:
					 self.id, @"id",
					 [NSNumber numberWithUnsignedInt:created], @"created",
					 language, @"language",
					 [URL absoluteString], @"URL",
					 title, @"title",
					 story, @"story",
					 [NSNumber numberWithUnsignedInt:clicks], @"clicks",
					 [NSNumber numberWithUnsignedInt:userID], @"userID",
					 userName, @"userName",
					 tags, @"tags",
					 categoryID, @"categoryID",
					 categoryName, @"categoryName",
					 status, @"status",
					 nil] description];
}

@end
