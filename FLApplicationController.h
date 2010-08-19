//
//  FLApplicationController.h
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <Flattr/OAConsumer.h>


@interface FLApplicationController : NSObject {
	OAConsumer *consumer;
	
	NSTextField *appKey;
	NSTextField *appSecret;
	NSTextField *token;
	NSTextField *tokenSecret;
}

@property (nonatomic, retain) IBOutlet NSTextField *appKey;
@property (nonatomic, retain) IBOutlet NSTextField *appSecret;
@property (nonatomic, retain) IBOutlet NSTextField *token;
@property (nonatomic, retain) IBOutlet NSTextField *tokenSecret;

- (IBAction)requestToken:(id)sender;

@end
