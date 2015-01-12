//
// Created by Orlando Schäfer on 17/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ACSPinKeyboardController;
@protocol ACSPinKeyboard;


@protocol ACSPinKeyboardDelegate <NSObject>

- (void)pinKeyboardController:(UIViewController <ACSPinKeyboard> *)pinKeyboardController didEnterCharacter:(NSString *)character textString:(NSString *)textString;

- (void)pinKeyboardController:(UIViewController <ACSPinKeyboard> *)pinKeyboardController didFinishEnteringText:(NSString *)textString;

- (void)pinKeyboardController:(UIViewController <ACSPinKeyboard> *)pinKeyboardController didResetText:(NSString *)textString;

@end