//
// Created by Orlando Schäfer on 18/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol ACSPinControllerDelegate <NSObject>

@optional

- (void)pinChangeController:(UIViewController *)pinChangeController didChangePin:(NSString *)pin;
- (void)pinCreateController:(UIViewController *)pinCreateController didCreatePin:(NSString *)pin;
- (void)pinController:(UIViewController *)pinController didVerifyPin:(NSString *)pin;
- (void)pinControllerDidEnterWrongPin:(UIViewController *)pinController lastRetry:(BOOL)lastRetry;
- (void)pinControllerCouldNotVerifyPin:(UIViewController *)pinController;
- (void)pinControllerCouldNotVerifyTouchID:(UIViewController *)pinController withError:(NSError *)error;

- (void)pinControllerDidSelectCancel:(UIViewController *)pinController;
- (void)pinController:(UIViewController *)pinController didSelectCustomActionButton:(UIButton *)actionButton;

@end