//
//  FLApplicationController.m
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLApplicationController.h"

#import <Flattr/FLToken.h>


@implementation FLApplicationController
@synthesize appKey;
@synthesize appSecret;
@synthesize token;
@synthesize tokenSecret;

- (void)awakeFromNib {
	consumer = [[OAConsumer alloc] initWithKey:@"f9QAER8q0CHFZVjBTI9Wm36DwD1w4qKaqrAV8ybZ1JvQvFiedh0pbWSxqKUl1vlh"
										secret:@"NL2La4B1DWHZsP3vXULYHtmX469Vsk35WVHWQ8NjVk8d02zNMaCjuP7oM6a4g4Z2"];
	
	[appKey setStringValue:consumer.key];
	[appSecret setStringValue:consumer.secret];
}

- (IBAction)requestToken:(id)sender {
	NSError *err = noErr;
	FLToken *requestedToken = [FLToken requestTokenForConsumer:consumer
														 error:&err];
	
	if (err == noErr) {
		[token setStringValue:requestedToken.key];
		[tokenSecret setStringValue:requestedToken.secret];
	}
	else {
		NSLog(@"error: %@", [err localizedDescription]);
	}
	
}

@end
