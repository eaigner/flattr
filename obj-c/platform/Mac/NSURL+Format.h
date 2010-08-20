//
//  NSURL+Format.h
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSURL (Format)

+ (NSURL *)URLWithFormat:(NSString *)format, ...;

@end
