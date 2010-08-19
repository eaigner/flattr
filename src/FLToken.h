//
//  FLToken.h
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "OAToken.h"


@class OAConsumer;

@interface FLToken : OAToken {

}

+ (FLToken *)requestTokenForConsumer:(OAConsumer *)consumer error:(NSError **)err;

- (BOOL)authorize;

@end
