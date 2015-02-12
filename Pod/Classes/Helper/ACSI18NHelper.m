//
// Created by Orlando Schäfer on 09/01/15.
// Copyright (c) 2015 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSI18NHelper.h"

NSString* const kACSButtonCancelTitle = @"acspinkit.button.cancel.title";
NSString* const kACSButtonActionTitle = @"acspinkit.button.action.title";
NSString* const kACSButtonDeleteTitle = @"acspinkit.button.delete.title";

NSString* const kACSVerifyHeaderText = @"acspinkit.verify.header.text";
NSString* const kACSVerifyAlertInitialText = @"acspinkit.verify.alert.initial.text";
NSString* const kACSVerifyAlertSingularText = @"acspinkit.verify.alert.singular.text";
NSString* const kACSVerifyAlertPluralText = @"acspinkit.verify.alert.plural.text";

NSString* const kACSChangeHeaderText = @"acspinkit.change.header.text";

NSString* const kACSCreateHeaderInitialText = @"acspinkit.create.header.initial.text";
NSString* const kACSCreateHeaderRepeatText = @"acspinkit.create.header.repeat.text";
NSString* const kACSCreateAlertText = @"acspinkit.create.alert.text";

NSString* const kACSTouchIDReasonText = @"acspinkit.touchid.reason.text";
NSString* const kACSTouchIDFallbackButtonTitle = @"acspinkit.touchid.button.fallback.title";

@implementation ACSI18NHelper

+ (NSString *)i18nStringForKey:(NSString *)key {
    
    if (!key) {
        return @"";
    }
    
    
    // If user has own strings table (ACSPinKit_I18NCustom), take the one from his table
    NSString *appSpecificLocalizationString = NSLocalizedStringFromTable(key, @"ACSPinKit_I18NCustom", nil);
    if (appSpecificLocalizationString && ![key isEqualToString:appSpecificLocalizationString]) {
        return appSpecificLocalizationString;
    }
    // ... otherwise we use the shipped table with this pod
    else if ([self acsPinBundle]) {
        
        NSString *bundleSpecificLocalizationString = NSLocalizedStringFromTableInBundle(key, @"ACSPinKit_I18N", [self acsPinBundle], @"");
        if (![bundleSpecificLocalizationString isEqualToString:key]) {
            return bundleSpecificLocalizationString;
        }
        return key;
    }
    else {
        
        return key;
    }
}

+ (NSBundle *)acsPinBundle {

    NSString *mainBundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"ACSPinKitResources.bundle"];
    return [NSBundle bundleWithPath:frameworkBundlePath];
}

@end