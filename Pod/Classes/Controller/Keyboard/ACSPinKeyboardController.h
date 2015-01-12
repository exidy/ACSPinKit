//
//  ACSPinKeyboardController.h
//  PinTest
//
//  Created by Orlando Schäfer on 25/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSPinKeyboardDelegate.h"
#import "ACSPinKeyboard.h"

@class ACSPinNumberPadView;
@protocol ACSPinNumberPad;


@interface ACSPinKeyboardController : UIViewController <ACSPinKeyboard>

@property (nonatomic, weak) id <ACSPinKeyboardDelegate> keyboardDelegate;
@property (nonatomic, strong) UIView <ACSPinNumberPad> *keyboardView;

@end
