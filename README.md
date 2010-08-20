## Implementations

* Objective-C

Feel free to push your implementations (in any language).

## Example (ObjC)

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