//
//  ACSPinFormatterHelper.h
//  PinTest
//
//  Created by Orlando Schäfer on 25/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACSPinFormatterHelper : NSObject

+ (NSString *)secure4DigitsPasscodeStringForString:(NSString *)string;
+ (NSUInteger)integerFromNumberString:(NSString *)numberString;
+ (NSString *)numberStringFromInteger:(NSUInteger)integer;

@end
