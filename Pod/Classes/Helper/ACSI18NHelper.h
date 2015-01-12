//
// Created by Orlando Schäfer on 09/01/15.
// Copyright (c) 2015 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ACSI18NString(key) \
        [ACSI18NHelper i18nStringForKey:(key)]

extern NSString* const kACSButtonCancelTitle;
extern NSString* const kACSButtonActionTitle;
extern NSString* const kACSButtonDeleteTitle;

extern NSString* const kACSVerifyHeaderText;
extern NSString* const kACSVerifyAlertInitialText;
extern NSString* const kACSVerifyAlertSingularText;
extern NSString* const kACSVerifyAlertPluralText;

extern NSString* const kACSChangeHeaderText;

extern NSString* const kACSCreateHeaderInitialText;
extern NSString* const kACSCreateHeaderRepeatText;
extern NSString* const kACSCreateAlertText;


@interface ACSI18NHelper : NSObject

+ (NSString *)i18nStringForKey:(NSString *)key;

@end