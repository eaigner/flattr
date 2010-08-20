//
//  NSError+Ext.m
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "NSError+Ext.h"


@implementation NSError (Ext)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code localizedDescription:(NSString *)desc {
	return [NSError errorWithDomain:domain
														 code:code
												 userInfo:[NSDictionary dictionaryWithObject:desc
																															forKey:NSLocalizedDescriptionKey]];
}

@end
