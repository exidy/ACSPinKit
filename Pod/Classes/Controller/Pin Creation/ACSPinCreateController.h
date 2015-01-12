//
//  ACSPinCreateController.h
//  PinTest
//
//  Created by Orlando Schäfer on 26/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSPinKeyboardDelegate.h"

@class ACSPinCreateController;

@protocol ACSPinKeyboard;
@protocol ACSPinDisplay;


@protocol ACSPinCreateDelegate <NSObject>

@required
- (void)pinCreateController:(ACSPinCreateController *)pinCreateController didCreatePIN:(NSString *)pin;

@optional
- (void)pinCreateController:(ACSPinCreateController *)pinCreateController didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem;

@end

@interface ACSPinCreateController : UIViewController <ACSPinKeyboardDelegate>

@property (nonatomic, strong) UIViewController <ACSPinKeyboard> *keyboardController;
@property (nonatomic, strong) UIViewController <ACSPinDisplay> *displayController;

@property (nonatomic, weak) id <ACSPinCreateDelegate> pinCreateDelegate;

@end
