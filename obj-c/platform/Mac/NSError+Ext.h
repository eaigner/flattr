//
//  NSError+Ext.h
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSError (Ext)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code localizedDescription:(NSString *)desc;

@end
