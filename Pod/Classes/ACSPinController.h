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


@interface ACSPinController : NSObject

@property (nonatomic) ACSPinCustomizer *pinCustomizer;

// Settings for PIN Controller
@property (nonatomic) NSUInteger retriesMax;

// Validation block for checking pin entering without storing pin (eg. you can test if the typed in pin unlocks a vault and return
// YES or NO. If this property is set, your pin will NOT be saved in the keychain.
@property (nonatomic, copy) BOOL (^validationBlock)(NSString *pin);

// Init the PIN Controller with a service and username
- (instancetype)initWithPinServiceName:(NSString *)pinServiceName andPinUserName:(NSString *)pinUserName delegate:(id <ACSPinControllerDelegate>)delegate;

// Touch ID Availability
- (BOOL)touchIDAvailable:(NSError **)error;

// Getting pin controllers for custom dismissal/actions on selection of a button
- (UIViewController *)verifyControllerForCustomPresentation;
- (UIViewController *)verifyControllerFullscreenForCustomPresentationUsingTouchID:(BOOL)touchID;


// PIN Controller presentation with auto dismissal
- (void)presentVerifyControllerFromViewController:(UIViewController *)viewController;
- (void)presentChangeControllerFromViewController:(UIViewController *)viewController;
- (void)presentCreateControllerFromViewController:(UIViewController *)viewController;


// Get and reset the saved pin
- (NSString *)storedPin;
- (BOOL)storePin:(NSString *)pin;
- (BOOL)resetPIN;

@end
