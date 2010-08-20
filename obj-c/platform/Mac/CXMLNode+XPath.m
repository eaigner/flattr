//
//  CXMLNode+XPath.m
//  Flattr
//
//  Created by Erik Aigner on 20.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "CXMLNode+XPath.h"


@implementation CXMLNode (XPath)

- (NSString *)stringForXPath:(NSString *)path {
	NSError *err = noErr;
	NSArray *nodes = [self nodesForXPath:path error:&err];
	if ([nodes count] > 0 && err == noErr) {
		return [[nodes objectAtIndex:0] stringValue];
	}
	
	return nil;
}

- (NSArray *)stringArrayForNodesAtXPath:(NSString *)path {
	NSError *err = noErr;
	NSArray *nodes = [self nodesForXPath:path error:&err];
	if ([nodes count] > 0 && err == noErr) {
		NSMutableArray *collect = [NSMutableArray arrayWithCapacity:[nodes count]];
		for (CXMLNode *node in nodes) {
			[collect addObject:[node stringValue]];
		}
		
		return [NSArray arrayWithArray:collect];
	}
	
	return nil;
}

- (NSInteger)integerForXPath:(NSString *)path {
	return [[self stringForXPath:path] integerValue];
}

- (NSURL *)URLForXPath:(NSString *)path {
	NSString *string = [self stringForXPath:path];
	if (string) {
		return [NSURL URLWithString:string];
	}
	
	return nil;
}

@end
