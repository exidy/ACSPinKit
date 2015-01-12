//
//  ACSPinCustomizer.h
//  PinTest
//
//  Created by Orlando Schäfer on 08/01/15.
//  Copyright (c) 2015 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ACSPinCustomizer : NSObject

@property (nonatomic, strong) UIImage *titleImage;
@property (nonatomic, strong) UIImage *actionButtonImage;
@property (nonatomic, strong) NSString *actionButtonString;

@property (nonatomic, strong) UIColor *displayBackgroundColor;
@property (nonatomic, strong) UIColor *headerTitleColor;
@property (nonatomic, strong) UIColor *passcodeDotsColor;
@property (nonatomic, strong) UIColor *alertTextColor;

@property (nonatomic, strong) UIColor *keyboardBackgroundColor;
@property (nonatomic, strong) UIColor *keyboardTintColor;
@property (nonatomic, strong) UIColor *keyboardTitleColor;
@property (nonatomic, strong) UIColor *keyboardHighlightColor;


@end
