//
//  FLDataFetcher.h
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLResponse.h"


@class OAToken;
@class OAConsumer;
@class OAMutableURLRequest;

@interface FLDataFetcher : NSObject {
	OAMutableURLRequest *request_;
}

- (id)initWithEndpoint:(NSURL *)endpoint consumer:(OAConsumer *)consumer token:(OAToken *)token method:(NSString *)meth;
- (id)initWithRequest:(OAMutableURLRequest *)req;

/*
 * We are fetching synchronous, because it's much more convenient in 10.6
 * to do that with a dispatch_async(..) call to GCD
 * 
 * If you have the need for an async function feel free to add one
 */
- (FLResponse *)fetchSynchronous;

@end
