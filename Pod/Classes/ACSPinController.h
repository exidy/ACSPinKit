//
//  ACSPinController.h
//  PinTest
//
//  Created by Orlando Schäfer on 26/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSPinCustomizer.h"
#import "ACSPinControllerDelegate.h"


/**
 This is the main interface class you use for accessing all the features of ACSPinKit
 */
@interface ACSPinController : NSObject

/**
 Customization object for setting different things like colors, titles, messages and images
 */
@property (nonatomic) ACSPinCustomizer *pinCustomizer;

/**
 Set the maximum number of retry attempts. Default value is 3.
 */
@property (nonatomic) NSUInteger retriesMax;

/**
 A validation block used for checking if the pin the user entered was valid. E.g. you can test if the typed in pin unlocks a vault and
 return YES or NO. If you provide this validation block the pin is NOT stored in the keychain.
 */
@property (nonatomic, copy) BOOL (^validationBlock)(NSString *pin);

/**
 Initializes and returns the pin controller object you can use to make further actions.
 
 @param pinServiceName A service name that is used for storing the pin in the keychain.
 @param pinUserName A username that is used for storing the pin in the keychain.
 @param accessGroup The access group used for keychain access. If this parameter is nil the standard group is used.
 
 @return An initialized pin controller object or nil if something went wrong
 */
- (instancetype)initWithPinServiceName:(NSString *)pinServiceName pinUserName:(NSString *)pinUserName accessGroup:(NSString *)accessGroup delegate:(id <ACSPinControllerDelegate>)delegate;

/**
 Returns if Touch ID is available or not (device does not support it, Touch ID is not enrolled etc.)
 You can provide an optional error pointer for getting detailed information if touch id is not available.
 
 @param error An error pointer for getting additional information in case that no touch id is available
 
 
 @return YES if Touch ID is available, NO if not.
 */
- (BOOL)touchIDAvailable:(NSError **)error;

/**
 The controller used for verifying a pin the user enters. You have to present and dismiss the controller manually
 */
- (UIViewController *)verifyControllerForCustomPresentation;

/**
 Full screen controller used for verifying a pin the user enters. You have to present and dismiss the controller manually
 In addition you can provide a boolean value that indicates if Touch ID should be used or not.
 */
- (UIViewController *)verifyControllerFullscreenForCustomPresentationUsingTouchID:(BOOL)touchID;


/**
 Presents the verification controller from a provided view controller
 */
- (void)presentVerifyControllerFromViewController:(UIViewController *)viewController;
/**
 Presents the change pin controller from a provided view controller
 */
- (void)presentChangeControllerFromViewController:(UIViewController *)viewController;
/**
 Presents the pin creation controller from a provided view controller
 */
- (void)presentCreateControllerFromViewController:(UIViewController *)viewController;


/**
 Get the current stored pin. The pin will only be stored in the keychain, if you do not provide a validation block.
 If you want to store the pin manually you have to use the storePin: method.
 */
- (NSString *)storedPin;
/**
 Stores a given pin to the keychain.
 */
- (BOOL)storePin:(NSString *)pin;
/**
 Removes the stored pin from the keychain.
 */
- (BOOL)resetPIN;

@end
