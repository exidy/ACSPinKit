//
//  ACSPinVerifyController.h
//  PinTest
//
//  Created by Orlando Schäfer on 12/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSPinKeyboardDelegate.h"

@class ACSPinVerifyController;
@protocol ACSPinDisplay;
@protocol ACSPinKeyboard;


@protocol ACSPinVerifyDelegate <NSObject>

@required
- (BOOL)pinValidForPinVerifyController:(ACSPinVerifyController *)pinVerifyController forEnteredPin:(NSString *)pin;

- (NSUInteger)retriesMaxForPinVerifyController:(ACSPinVerifyController *)pinVerifyController;
- (BOOL)alreadyHasRetriesForPinVerifyController:(ACSPinVerifyController *)pinVerifyController;

- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didVerifyPIN:(NSString *)pin;
- (void)pinVerifyControllerDidEnterWrongPIN:(ACSPinVerifyController *)pinVerifyController onlyOneRetryLeft:(BOOL)onlyOneRetryLeft;
- (void)pinVerifyControllerCouldNotVerifyPIN:(ACSPinVerifyController *)pinVerifyController;

@optional
- (NSString *)pinStringForPinVerifyController:(ACSPinVerifyController *)pinVerifyController;
- (void)pinVerifyControllerCouldNotVerifyTouchID:(ACSPinVerifyController *)pinVerifyController withError:(NSError *)error;
- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem;
- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didSelectActionButton:(UIButton *)actionButton;

@end


@interface ACSPinVerifyController : UIViewController <ACSPinKeyboardDelegate>

@property (nonatomic, strong) UIViewController <ACSPinKeyboard> *keyboardController;
@property (nonatomic, strong) UIViewController <ACSPinDisplay> *displayController;

@property (nonatomic, weak) id <ACSPinVerifyDelegate> pinVerifyDelegate;
@property (nonatomic, copy) NSString *headerString;

- (void)addChildControllers;
@end

