//
// Created by Orlando Schäfer on 18/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ACSPinNumberPad.h"
#import "ACSPinNumberCircleButton.h"




@interface ACSPinNumberPadCircleView : UIView <ACSPinNumberPad>

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor buttonTintColor:(UIColor *)buttonTintColor buttonTitleColor:(UIColor *)buttonTitleColor buttonHighlightColor:(UIColor *)buttonHighlightColor;

@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button1;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button2;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button3;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button4;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button5;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button6;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button7;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button8;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button9;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button0;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *buttonDelete;

@property (nonatomic, strong) UIColor *buttonTintColor;
@property (nonatomic, strong) UIColor *buttonTitleColor;
@property (nonatomic, strong) UIColor *buttonHighlightColor;

@end