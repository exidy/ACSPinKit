//
// Created by Orlando Schäfer on 17/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ACSPinKeyboard <NSObject>

@required

- (void)setKeyboardDelegate:(id <ACSPinKeyboardDelegate>)keyboardDelegate;
- (id <ACSPinKeyboardDelegate>)keyboardDelegate;

- (void)reset;

@end