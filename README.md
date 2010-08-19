# Flattr Objective-C API Library

All methods are supposed to be called synchronously by wrapping them into a dispatch_async(..) like so.

	dispatch_async(dispatch_get_fl_queue(), ^{
		
		// setup consumer and stuff ...
		
		NSError *err = noErr;
		FLToken *token = [FLToken requestTokenForConsumer:consumer error:&err]
		
		// do something with token ...
	})