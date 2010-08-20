//
//  FLResponse.h
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


extern NSString * const FLAPIErrorDomainName;

@interface FLResponse : NSObject {
@private
	NSHTTPURLResponse	*response;
	NSData				*responseData;
	NSError				*error;
}

@property (nonatomic, retain, readonly) NSHTTPURLResponse *response;
@property (nonatomic, retain, readonly) NSData *responseData;
@property (nonatomic, retain, readonly) NSString *UTF8Body;
@property (nonatomic, retain, readonly) NSError *error;

- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)aResponse
												 data:(NSData *)bodyData
												error:(NSError *)err;

- (BOOL)isValid;

@end
