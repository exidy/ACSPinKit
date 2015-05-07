//
//  ACSPinChangeController.h
//  PinTest
//
//  Created by Orlando Schäfer on 26/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSPinCreateController.h"
#import "ACSPinVerifyController.h"

@class ACSPinChangeController;


@protocol ACSPinChangeDelegate <NSObject>

@required
- (BOOL)pinValidForPinVerifyController:(ACSPinChangeController *)pinVerifyController forEnteredPin:(NSString *)pin;

- (NSUInteger)retriesMaxForPinChangeController:(ACSPinChangeController *)pinChangeController;
- (BOOL)alreadyHasRetriesForPinChangeController:(ACSPinChangeController *)pinChangeController;

- (void)pinChangeController:(ACSPinChangeController *)pinChangeController didChangePIN:(NSString *)pin;
- (void)pinChangeControllerCouldNotVerifyOldPIN:(ACSPinChangeController *)pinChangeController;
- (void)pinChangeController:(ACSPinChangeController *)pinChangeController didVerifyOldPIN:(NSString *)pin;
- (void)pinChangeControllerDidEnterWrongOldPIN:(ACSPinChangeController *)pinChangeController onlyOneRetryLeft:(BOOL)onlyOneRetryLeft;

@optional
- (void)pinChangeController:(ACSPinChangeController *)pinChangeController didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem;

@end

@interface ACSPinChangeController : UIViewController <ACSPinVerifyDelegate, ACSPinCreateDelegate>

@property (nonatomic, strong) ACSPinVerifyController *pinVerifyController;
@property (nonatomic, strong) ACSPinCreateController *pinCreateController;

@property (nonatomic, weak) id <ACSPinChangeDelegate> pinChangeDelegate;

@end
