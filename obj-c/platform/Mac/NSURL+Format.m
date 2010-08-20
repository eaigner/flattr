//
//  NSURL+Format.m
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "NSURL+Format.h"


@implementation NSURL (Format)

+ (NSURL *)URLWithFormat:(NSString *)format, ... {
	va_list args;
	va_start(args, format);
	NSString *urlString = [[NSString alloc] initWithFormat:format arguments:args];
	va_end(args);
	
	return [NSURL URLWithString:[urlString autorelease]];
}

@end
