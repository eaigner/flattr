//
//  FLCommon.m
//  Flattr
//
//  Created by Erik Aigner on 19.08.10.
//  Copyright 2010 chocomoko.com. All rights reserved.
//

#import "FLCommon.h"


static dispatch_queue_t flattr_dispatch_queue_;

dispatch_queue_t dispatch_get_flattr_queue() {
	if (flattr_dispatch_queue_ == NULL) {
		flattr_dispatch_queue_ = dispatch_queue_create("com.chocomoko.FlattrQueue", NULL);
	}
	return flattr_dispatch_queue_;
}
