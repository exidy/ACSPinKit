# ACSPinKit

<p align="center" >
  <img src="https://github.com/arconsis/ACSPinKit/raw/master/Resources/ACSPinKit.png">
</p>

## Try it out!

To run the example project, just type `pod try ACSPinKit`.

## Requirements
- min. Target iOS 7

## Installation

ACSPinKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ACSPinKit"
    
## Features
- Create a pin code
- Verify pin code
- Change pin code
- Customize titles, colors and images
- Fullscreen verification controller
- Touch ID Support
- Very modular code design
- iPhone and iPad Support

## Screenshots

<br>
<br>
<p align="center" >
	<img src="https://github.com/arconsis/ACSPinKit/raw/master/Resources/ACS1.PNG" width="30%" height="30%" alt="ACS" title="ACS" border="1">
  <img src="https://github.com/arconsis/ACSPinKit/raw/master/Resources/ACS2.PNG" width="30%" height="30%" alt="ACS" title="ACS" border="1">
  <img src="https://github.com/arconsis/ACSPinKit/raw/master/Resources/ACS3.PNG" width="30%" height="30%" alt="ACS" title="ACS" border="1">
</p>
<br>
<br>

## Getting started

For getting started just initialize the pin controller with a given user, service and access group. All pin controller instances with these same values share the same pin 'domain'.

```objective-c
	self.pinController = [[ACSPinController alloc] initWithPinServiceName:@"testservice" pinUserName:@"testuser" accessGroup:@"accesstest" delegate:self];
    self.pinController.retriesMax = 5;
    // Validation block for pin controller to check if entered pin is valid.
    self.pinController.validationBlock = ^(NSString *pin) {
        // Check if 'pin' unlocks a vault or something similar...
    };
```

If you provide a `validationBlock` the pin controller does not store the created pin in the keychain. So then you have to store it manually (with the `storePin:` message).
If you want to use Touch ID you have to ensure, that you pin is stored in the keychain.

After you did setup the pin controller just perform one of the following use cases:

### Create PIN

```objective-c
	[self.pinController presentCreateControllerFromViewController:self];
```

### Verify PIN

```objective-c
	[self.pinController presentVerifyControllerFromViewController:self];
```

### Change PIN

```objective-c
	[self.pinController presentChangeControllerFromViewController:self];
```

### Verify PIN (Fullscreen style with circle buttons)

```objective-c
	UIViewController *pinController = [self.pinController verifyControllerFullscreenForCustomPresentationUsingTouchID:useTouchID];
	// Present the pinController however you want - Maybe as rootViewController of the window?
```

The pin controller also provides a method for testing if Touch ID is available

```objective-c
	NSError *error = nil;
	BOOL useTouchID = [self.pinController touchIDAvailable:&error]
	// Present the pinController however you want - Maybe as rootViewController of the window?
```


## Author

arconsis IT-Solutions GmbH <contact@arconsis.com>

## License

The MIT License (MIT)

Copyright (c) 2015 arconsis IT-Solutions GmbH <contact@arconsis.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

