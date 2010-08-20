## Example

All methods are supposed to be called asynchronously by wrapping them into a dispatch_async(..) like so.

	dispatch_async(dispatch_get_flattr_queue(), ^{
		
		// Request token from flattr
		NSError *err = noErr;
		FLToken *token = [FLToken requestTokenForConsumer:consumer error:&err];
		
		// If we got no error, redirect user to auth page
		if (err == noErr) {
			dispatch_async(dispatch_get_main_queue(), ^{
				[token openAuthorizationPageRequiringAccessLevel:kFLSuperAccessLevelMask];
			});
		}
		else {
			NSLog(@"error: could not fetch flattr token");
		}
	});