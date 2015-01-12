//
// Created by Orlando Schäfer on 19/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ACSPinNumberButton;
@protocol ACSPinNumberPadItem;


@protocol ACSPinNumberPad <NSObject>

- (void)setButton1:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button1;

- (void)setButton2:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button2;

- (void)setButton3:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button3;

- (void)setButton4:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button4;

- (void)setButton5:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button5;

- (void)setButton6:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button6;

- (void)setButton7:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button7;

- (void)setButton8:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button8;

- (void)setButton9:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button9;

- (void)setButton0:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button0;

- (void)setButtonDelete:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)buttonDelete;


@end