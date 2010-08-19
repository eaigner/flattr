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

- (FLResponse *)fetchSynchronous;

@end
