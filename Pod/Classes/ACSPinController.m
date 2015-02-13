//
//  ACSPinController.m
//  PinTest
//
//  Created by Orlando Schäfer on 26/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinController.h"

// Controller
#import "ACSPinChangeController.h"
#import "ACSPinVerifyController.h"
#import "ACSPinCreateController.h"
#import "ACSPinVerifyTouchIDController.h"
#import "ACSPinVerifyFullscreenController.h"

#import "ACSPinKeyboardController.h"
#import "ACSPinDisplayController.h"

// Delegate Manager
#import "ACSPinDelegateManager.h"
#import "ACSPinChangeDelegateManager.h"
#import "ACSPinCreateDelegateManager.h"
#import "ACSPinVerifyDelegateManager.h"

// Views
#import "ACSPinNumberPadView.h"
#import "ACSPinNumberPadCircleView.h"
#import "ACSPinNumberButton.h"
#import "ACSPinNumberCircleButton.h"
#import "ACSPinDisplayView.h"
#import "ACSPinDisplayFullscreenView.h"

// Helper
#import "ACSI18NHelper.h"
#import "ACSKeychainHelper.h"
#import "ACSLocalAuthentication.h"


@interface ACSPinController ()

@property (nonatomic, strong) ACSPinDelegateManager *pinDelegateManager;


@end

@implementation ACSPinController

#pragma mark - Public

- (instancetype)initWithPinServiceName:(NSString *)pinServiceName andPinUserName:(NSString *)pinUserName delegate:(id <ACSPinControllerDelegate>)delegate
{

    self = [super init];
    if (self) {
        NSAssert(pinServiceName.length > 0, @"ACSPinController initialization: Parameter 'pinServiceName' must not be nil!");
        NSAssert(pinUserName.length > 0, @"ACSPinController initialization: Parameter 'pinUserName' must not be nil!");

        ACSKeychainHelper *keychainHelper = [[ACSKeychainHelper alloc] initWithPinServiceName:pinServiceName andPinUserName:pinUserName];
        self.pinCustomizer = [[ACSPinCustomizer alloc] init];
        
        self.pinDelegateManager = [[ACSPinDelegateManager alloc] init];
        self.pinDelegateManager.keychainHelper = keychainHelper;
        self.pinDelegateManager.pinControllerDelegate = delegate;

        ACSPinCreateDelegateManager *pinCreateDelegateManager = [[ACSPinCreateDelegateManager alloc] init];
        ACSPinVerifyDelegateManager *pinVerifyDelegateManager = [[ACSPinVerifyDelegateManager alloc] init];
        ACSPinChangeDelegateManager *pinChangeDelegateManager = [[ACSPinChangeDelegateManager alloc] init];

        self.pinDelegateManager.pinChangeDelegateManager = pinChangeDelegateManager;
        self.pinDelegateManager.pinCreateDelegateManager = pinCreateDelegateManager;
        self.pinDelegateManager.pinVerifyDelegateManager = pinVerifyDelegateManager;

        self.retriesMax = 3;

    }
    return self;
}

- (UIViewController *)verifyControllerForCustomPresentation
{
    NSAssert([self storedPin].length > 0, @"ACSPinController: Verification not possible -> No stored PIN in keychain");
    
    UIViewController *pinController = [self verifyController];
    return pinController;
}

- (UIViewController *)verifyControllerFullscreenForCustomPresentationUsingTouchID:(BOOL)touchID
{
    NSAssert([self storedPin].length > 0, @"ACSPinController: Verification not possible -> No stored PIN in keychain");

    UIViewController *pinController = touchID ? [self verifyControllerTouchID] : [self verifyControllerFullscreen];
    return pinController;
}

- (void)presentVerifyControllerFromViewController:(UIViewController *)viewController
{
    UIViewController *pinController = [self verifyController];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:pinController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [viewController presentViewController:navigationController animated:YES completion:nil];
}

- (void)presentChangeControllerFromViewController:(UIViewController *)viewController
{
    NSAssert([self storedPin].length > 0, @"ACSPinController: Change PIN not possible -> No stored PIN in keychain");
    
    UIViewController *pinController = [self changeController];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:pinController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [viewController presentViewController:navigationController animated:YES completion:nil];
}

- (void)presentCreateControllerFromViewController:(UIViewController *)viewController
{
    UIViewController *pinController = [self createController];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:pinController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [viewController presentViewController:navigationController animated:YES completion:nil];
}

- (BOOL)touchIDAvailable:(NSError **)error
{
    return [ACSLocalAuthentication biometricsAuthenticationAvailable:error];
}

- (NSString *)storedPin
{
    return [self.pinDelegateManager storedPin];
}

- (BOOL)resetPIN
{
    return [self.pinDelegateManager resetPIN];
}

- (void)setRetriesMax:(NSUInteger)retriesMax
{
    _retriesMax = retriesMax;

    self.pinDelegateManager.retriesMax = _retriesMax;
}

#pragma mark - Private (Setting up dependencies)

- (ACSPinVerifyTouchIDController *)verifyControllerTouchID
{
    ACSPinVerifyTouchIDController *pinVerifyController = [[ACSPinVerifyTouchIDController alloc] init];
    [self configureVerifyFullscreenController:pinVerifyController];

    NSError *error;
    if ([ACSLocalAuthentication biometricsAuthenticationAvailable:&error]) {
        ACSLocalAuthentication *localAuthentication = [[ACSLocalAuthentication alloc] init];
        localAuthentication.reasonText = self.pinCustomizer.touchIDReasonText;
        localAuthentication.fallbackButtonTitle = self.pinCustomizer.touchIDFallbackTitle;
        localAuthentication.delegate = pinVerifyController;
        pinVerifyController.localAuthentication = localAuthentication;
    }
    
    return pinVerifyController;
}

- (ACSPinVerifyFullscreenController *)verifyControllerFullscreen
{
    ACSPinVerifyFullscreenController *pinVerifyController = [[ACSPinVerifyFullscreenController alloc] init];
    [self configureVerifyFullscreenController:pinVerifyController];

    return pinVerifyController;
}

- (void)configureVerifyFullscreenController:(ACSPinVerifyFullscreenController *)pinVerifyController
{
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    actionButton.tintColor = self.pinCustomizer.headerTitleColor;
    if (self.pinCustomizer.actionButtonImage) {
        [actionButton setImage:self.pinCustomizer.actionButtonImage forState:UIControlStateNormal];
    }
    else {
        [actionButton setTitle:self.pinCustomizer.actionButtonString forState:UIControlStateNormal];
    }
    pinVerifyController.actionButton = actionButton;
    pinVerifyController.headerString = ACSI18NString(kACSVerifyHeaderText);
    
    // Set keyboard for pin verification
    ACSPinKeyboardController *keyboardController = [[ACSPinKeyboardController alloc] init];
    ACSPinNumberPadCircleView *keyboardView = [[ACSPinNumberPadCircleView alloc] initWithBackgroundColor:self.pinCustomizer.keyboardBackgroundColor
                                                                                         buttonTintColor:self.pinCustomizer.keyboardTintColor
                                                                                        buttonTitleColor:self.pinCustomizer.keyboardTitleColor
                                                                                    buttonHighlightColor:self.pinCustomizer.keyboardHighlightColor];
    keyboardController.keyboardDelegate = pinVerifyController;
    keyboardController.keyboardView = keyboardView;
    pinVerifyController.keyboardController = keyboardController;
    
    // Set display for pin verification
    ACSPinDisplayController *displayController = [[ACSPinDisplayController alloc] init];
    ACSPinDisplayFullscreenView *displayView = [[ACSPinDisplayFullscreenView alloc] init];
    displayView.imageView.image = self.pinCustomizer.titleImage;
    displayView.backgroundColor = self.pinCustomizer.displayBackgroundColor;
    displayView.headerLabel.textColor = self.pinCustomizer.headerTitleColor;
    displayView.passcodeLabel.textColor = self.pinCustomizer.passcodeDotsColor;
    displayView.alertLabel.textColor = self.pinCustomizer.alertTextColor;
    displayController.displayView = displayView;
    pinVerifyController.displayController = displayController;
    
    pinVerifyController.pinVerifyDelegate = self.pinDelegateManager.pinVerifyDelegateManager;
}

- (ACSPinVerifyController *)verifyController
{
    ACSPinVerifyController *pinVerifyController = [[ACSPinVerifyController alloc] init];
    pinVerifyController.headerString = ACSI18NString(kACSVerifyHeaderText);

    // Set keyboard for pin verification
    ACSPinKeyboardController *keyboardController = [[ACSPinKeyboardController alloc] init];
    ACSPinNumberPadView *keyboardView = [[ACSPinNumberPadView alloc] initWithBackgroundColor:self.pinCustomizer.keyboardBackgroundColor
                                                                             buttonTintColor:self.pinCustomizer.keyboardTintColor
                                                                            buttonTitleColor:self.pinCustomizer.keyboardTitleColor
                                                                        buttonHighlightColor:self.pinCustomizer.keyboardHighlightColor];
    keyboardController.keyboardDelegate = pinVerifyController;
    keyboardController.keyboardView = keyboardView;
    pinVerifyController.keyboardController = keyboardController;

    // Set display for pin verification
    ACSPinDisplayController *displayController = [[ACSPinDisplayController alloc] init];
    ACSPinDisplayView *displayView = [[ACSPinDisplayView alloc] init];
    displayView.imageView.image = self.pinCustomizer.titleImage;
    displayView.backgroundColor = self.pinCustomizer.displayBackgroundColor;
    displayView.headerLabel.textColor = self.pinCustomizer.headerTitleColor;
    displayView.passcodeLabel.textColor = self.pinCustomizer.passcodeDotsColor;
    displayView.alertLabel.textColor = self.pinCustomizer.alertTextColor;
    displayController.displayView = displayView;
    pinVerifyController.displayController = displayController;

    pinVerifyController.pinVerifyDelegate = self.pinDelegateManager.pinVerifyDelegateManager;
    
    return pinVerifyController;
}

- (ACSPinCreateController *)createController
{
    ACSPinCreateController *pinCreateController = [[ACSPinCreateController alloc] init];

    // Set keyboard for pin creation
    ACSPinKeyboardController *keyboardController = [[ACSPinKeyboardController alloc] init];
    ACSPinNumberPadView *keyboardView = [[ACSPinNumberPadView alloc] initWithBackgroundColor:self.pinCustomizer.keyboardBackgroundColor
                                                                             buttonTintColor:self.pinCustomizer.keyboardTintColor
                                                                            buttonTitleColor:self.pinCustomizer.keyboardTitleColor
                                                                        buttonHighlightColor:self.pinCustomizer.keyboardHighlightColor];
    keyboardController.keyboardDelegate = pinCreateController;
    keyboardController.keyboardView = keyboardView;
    pinCreateController.keyboardController = keyboardController;

    // Set display for pin creation
    ACSPinDisplayController *displayController = [[ACSPinDisplayController alloc] init];
    ACSPinDisplayView *displayView = [[ACSPinDisplayView alloc] init];
    displayView.imageView.image = self.pinCustomizer.titleImage;
    displayView.backgroundColor = self.pinCustomizer.displayBackgroundColor;
    displayView.headerLabel.textColor = self.pinCustomizer.headerTitleColor;
    displayView.passcodeLabel.textColor = self.pinCustomizer.passcodeDotsColor;
    displayView.alertLabel.textColor = self.pinCustomizer.alertTextColor;
    displayController.displayView = displayView;
    pinCreateController.displayController = displayController;

    pinCreateController.pinCreateDelegate = self.pinDelegateManager.pinCreateDelegateManager;
    
    return pinCreateController;
}

- (ACSPinChangeController *)changeController
{
    ACSPinChangeController *pinChangeController = [[ACSPinChangeController alloc] init];

    ACSPinVerifyController *pinVerifyController = [self verifyController];
    pinVerifyController.pinVerifyDelegate = pinChangeController;
    pinVerifyController.headerString = ACSI18NString(kACSChangeHeaderText);

    ACSPinCreateController *pinCreateController = [self createController];
    pinCreateController.pinCreateDelegate = pinChangeController;

    pinChangeController.pinVerifyController = pinVerifyController;
    pinChangeController.pinCreateController = pinCreateController;
    pinChangeController.pinChangeDelegate = self.pinDelegateManager.pinChangeDelegateManager;

    return pinChangeController;
}


@end
