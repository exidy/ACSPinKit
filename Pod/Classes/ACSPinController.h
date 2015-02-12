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

// Init the PIN Controller with a service and username
- (instancetype)initWithPinServiceName:(NSString *)pinServiceName andPinUserName:(NSString *)pinUserName delegate:(id <ACSPinControllerDelegate>)delegate;

// Getting pin controllers for custom dismissal/actions on selection of a button
- (UIViewController *)verifyControllerForCustomPresentation;

- (UIViewController *)verifyControllerFullscreenForCustomPresentationUsingTouchID:(BOOL)touchID;


// PIN Controller presentation with auto dismissal
- (void)presentVerifyControllerFromViewController:(UIViewController *)viewController;
- (void)presentChangeControllerFromViewController:(UIViewController *)viewController;
- (void)presentCreateControllerFromViewController:(UIViewController *)viewController;


// Get and reset the saved pin
- (NSString *)storedPin;
- (BOOL)resetPIN;

@end
