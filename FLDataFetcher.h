//
//  FLDataFetcher.h
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class OAToken;
@class OAConsumer;
@class FLResponse;

@interface FLDataFetcher : NSObject {
	NSURL *endpoint_;
	OAConsumer *consumer_;
	OAToken *token_;
	NSString *method_;
}

- (id)initWithEndpoint:(NSURL *)endpoint consumer:(OAConsumer *)consumer
				 token:(OAToken *)token method:(NSString *)httpMethod;

/*
 * We are fetching synchronous, because it's much more convenient in 10.6
 * to do that with a dispatch_async(..) call to GCD
 * 
 * If you have the need for an async function feel free to add one
 */
- (FLResponse *)fetchSynchronous;

@end
