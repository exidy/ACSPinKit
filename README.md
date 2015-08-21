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

For getting started just initialize the pin controller with a given user, service and access group. All pin controller instances with the same values share the same pin 'domain'.

```objective-c
	self.pinController = [[ACSPinController alloc] initWithPinServiceName:@"testservice" pinUserName:@"testuser" accessGroup:@"accesstest" delegate:self];
    self.pinController.retriesMax = 5;
    // Validation block for pin controller to check if entered pin is valid.
    self.pinController.validationBlock = ^(NSString *pin) {
        // Check if 'pin' unlocks a vault or something similar...
    };
```

`retriesMax` indicate how often a user can attempt to verify the pin. All pin controller instances in the same pin 'domain' share this count. So we can ensure that the count gets decremented ... even if we use the same pin 'domain' in another app (via AppGroups and Keychain Access groups).

If you provide a `validationBlock` the pin controller does not store the created pin in the keychain. So then you have to store it manually (with the `storePin:` message).
If you want to use Touch ID you have to ensure, that your pin is stored in the keychain.

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

## Delegate Methods

```objective-c
/**
This method is called after the pin code was changed successfully.
*/
- (void)pinChangeController:(UIViewController *)pinChangeController didChangePin:(NSString *)pin;
/**
 This method is called after the pin code was created successfully.
*/
- (void)pinCreateController:(UIViewController *)pinCreateController didCreatePin:(NSString *)pin;
/**
 This method is called after the pin code was verified successfully.
*/
- (void)pinController:(UIViewController *)pinController didVerifyPin:(NSString *)pin;
/**
 This method is called after the pin code was entered wrong. If there is only one retry left the lastRetry property is YES.
*/
- (void)pinControllerDidEnterWrongPin:(UIViewController *)pinController lastRetry:(BOOL)lastRetry;
/**
This method is called if the user reached the maximum number of attempts for entering the pin code. This means that the user could not
be verified and you should react properly to that event (e.g. logout user)
*/
- (void)pinControllerCouldNotVerifyPin:(UIViewController *)pinController;
/**
This method is called after touch id verification failed. For the user it fallbacks to the normal pin entering mode.
*/
- (void)pinControllerCouldNotVerifyTouchID:(UIViewController *)pinController withError:(NSError *)error;
/**
This message is send if the user selects the cancel button. If you have presented the pin controller manually you have to dismiss it here again.
*/
- (void)pinControllerDidSelectCancel:(UIViewController *)pinController;
/**
If the user selects the custom action button. Do whatever you want (e.g. show a menu)
*/
- (void)pinController:(UIViewController *)pinController didSelectCustomActionButton:(UIButton *)actionButton;
```

## Customization

Via `self.pinController.pinCustomizer` you can access the following properties.


```objective-c
/**
 A property for providing a custom title image for the fullscreen controller (e.g. company logo)
 */
@property (nonatomic, strong) UIImage *titleImage;
/**
 A property for providing a custom action button image for the fullscreen controller (e.g. a burger button icon)
 */
@property (nonatomic, strong) UIImage *actionButtonImage;
/**
 A property for providing a custom action button title for the fullscreen controller (e.g. 'Menu')
 */
@property (nonatomic, strong) NSString *actionButtonString;
/**
 The background color of the display (upper part of controller)
 */
@property (nonatomic, strong) UIColor *displayBackgroundColor;
/**
 The color of the title text / prompt text
 */
@property (nonatomic, strong) UIColor *headerTitleColor;
/**
 The color of the placeholder dots of the passcode
 */
@property (nonatomic, strong) UIColor *passcodeDotsColor;
/**
 The color of the alert text that appear when entering a wrong pin
 */
@property (nonatomic, strong) UIColor *alertTextColor;
/**
 The background color of the keypad
 */
@property (nonatomic, strong) UIColor *keyboardBackgroundColor;
/**
 The color of the keypad buttons
 */
@property (nonatomic, strong) UIColor *keyboardTintColor;
/**
 The color of the keypad button titles
 */
@property (nonatomic, strong) UIColor *keyboardTitleColor;
/**
 The highlight color of the keypad buttons (when touching them)
 */
@property (nonatomic, strong) UIColor *keyboardHighlightColor;
/**
 The reason text that appear when using touch id.
 */
@property (nonatomic, strong) NSString *touchIDReasonText;
/**
 The fallback title of the button after touch id fails.
 */
@property (nonatomic, strong) NSString *touchIDFallbackTitle;
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

