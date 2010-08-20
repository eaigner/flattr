//
//  FLThing.h
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FLThing : NSObject {
 @private
	NSString		*id;
	NSUInteger	created; // timestamp
	NSString		*language; // maybe map to NSLocale?
	NSURL				*URL;
	NSString		*title;
	// NSString *story;
	NSUInteger	clicks;
	NSUInteger	userID;
	NSString		*userName;
	NSArray			*tags;
	NSString		*categoryID;
	NSString		*categoryName;
	NSString		*status;
}

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, assign, readonly) NSUInteger created;
@property (nonatomic, copy, readonly) NSString *language;
@property (nonatomic, retain, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign, readonly) NSUInteger clicks;
@property (nonatomic, assign, readonly) NSUInteger userID;
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, retain, readonly) NSArray *tags;
@property (nonatomic, copy, readonly) NSString *categoryID;
@property (nonatomic, copy, readonly) NSString *categoryName;
@property (nonatomic, copy, readonly) NSString *status;

@end
