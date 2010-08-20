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
	NSString		*story;
	NSUInteger	clicks;
	NSUInteger	userID;
	NSString		*userName;
	NSArray			*tags;
	NSString		*categoryID;
	NSString		*categoryName;
	NSString		*status;
}

@property (nonatomic, copy) NSString *id;
@property (nonatomic, assign) NSUInteger created;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, retain) NSURL *URL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *story;
@property (nonatomic, assign) NSUInteger clicks;
@property (nonatomic, assign) NSUInteger userID;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, retain) NSArray *tags;
@property (nonatomic, copy) NSString *categoryID;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *status;

@end
