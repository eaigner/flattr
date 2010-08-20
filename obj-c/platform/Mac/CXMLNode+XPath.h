//
//  CXMLNode+XPath.h
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "CXMLNode.h"


@interface CXMLNode (XPath)

- (NSString *)stringForXPath:(NSString *)path;
- (NSArray *)stringArrayForNodesAtXPath:(NSString *)path;
- (NSInteger)integerForXPath:(NSString *)path;
- (NSURL *)URLForXPath:(NSString *)path;

@end
