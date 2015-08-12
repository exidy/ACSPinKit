//
//  ACSPinCustomizer.h
//  PinTest
//
//  Created by Orlando Schäfer on 08/01/15.
//  Copyright (c) 2015 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Customization object for colors, texts and images
 */
@interface ACSPinCustomizer : NSObject

/**
 A property for providing a custom title image for the fullscreen controller (e.g. company logo)
 */
@property (nonatomic, strong) UIImage *titleImage;
/**
 A property for providing a custom action button image for the fullscreen controller (e.g. a burger button icon)
 */
@property (nonatomic, strong) UIImage *actionButtonImage;
/**
 A property for providing a custom action button title for the fullscreen controller (e.g. 'Menu')
 */
@property (nonatomic, strong) NSString *actionButtonString;

/**
 The background color of the display (upper part of controller)
 */
@property (nonatomic, strong) UIColor *displayBackgroundColor;
/**
 The color of the title text / prompt text
 */
@property (nonatomic, strong) UIColor *headerTitleColor;
/**
 The color of the placeholder dots of the passcode
 */
@property (nonatomic, strong) UIColor *passcodeDotsColor;
/**
 The color of the alert text that appear when entering a wrong pin
 */
@property (nonatomic, strong) UIColor *alertTextColor;

/**
 The background color of the keypad
 */
@property (nonatomic, strong) UIColor *keyboardBackgroundColor;
/**
 The color of the keypad buttons
 */
@property (nonatomic, strong) UIColor *keyboardTintColor;

/**
 The color of the keypad button titles
 */
@property (nonatomic, strong) UIColor *keyboardTitleColor;

/**
 The highlight color of the keypad buttons (when touching them)
 */
@property (nonatomic, strong) UIColor *keyboardHighlightColor;

/**
 The reason text that appear when using touch id
 */
@property (nonatomic, strong) NSString *touchIDReasonText;

/**
 The fallback title of the button after touch id fails.
 */
@property (nonatomic, strong) NSString *touchIDFallbackTitle;

@end
