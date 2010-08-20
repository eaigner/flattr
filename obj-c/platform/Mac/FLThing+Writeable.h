//
//  FLThing+Writeable.h
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FLThing ()

@property (nonatomic, copy, readwrite) NSString *id;
@property (nonatomic, assign, readwrite) NSUInteger created;
@property (nonatomic, copy, readwrite) NSString *language;
@property (nonatomic, retain, readwrite) NSURL *URL;
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) NSUInteger clicks;
@property (nonatomic, assign, readwrite) NSUInteger userID;
@property (nonatomic, copy, readwrite) NSString *userName;
@property (nonatomic, retain, readwrite) NSArray *tags;
@property (nonatomic, copy, readwrite) NSString *categoryID;
@property (nonatomic, copy, readwrite) NSString *categoryName;
@property (nonatomic, copy, readwrite) NSString *status;

@end
