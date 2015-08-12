//
// Created by Orlando Schäfer on 18/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 A protocol that defines several optional callbacks that are triggerd after creating, verifying or changing you pin code.
 */
@protocol ACSPinControllerDelegate <NSObject>

@optional

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

@end