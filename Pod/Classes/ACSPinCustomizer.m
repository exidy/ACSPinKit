//
//  ACSPinCustomizer.m
//  PinTest
//
//  Created by Orlando Schäfer on 08/01/15.
//  Copyright (c) 2015 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinCustomizer.h"
#import "ACSI18NHelper.h"

@implementation ACSPinCustomizer

- (instancetype)init
{
    self = [super init];
    if (self) {

        [self resetDefaults];
    }

    return self;
}

- (void)resetDefaults
{
    self.titleImage = nil;
    self.actionButtonImage = nil;
    self.actionButtonString = ACSI18NString(kACSButtonActionTitle);

    self.displayBackgroundColor = [UIColor whiteColor];
    self.headerTitleColor = [UIColor blackColor];
    self.passcodeDotsColor = [UIColor blackColor];
    self.alertTextColor = [UIColor colorWithRed:0.85 green:0 blue:0 alpha:1];

    self.keyboardBackgroundColor = [UIColor lightGrayColor];
    self.keyboardTintColor = [UIColor whiteColor];
    self.keyboardTitleColor = [UIColor darkGrayColor];
    self.keyboardHighlightColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    self.touchIDReasonText = ACSI18NString(kACSTouchIDReasonText);
    self.touchIDFallbackTitle = ACSI18NString(kACSTouchIDFallbackButtonTitle);
}

@end
