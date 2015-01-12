//
//  ACSPinFormatterHelper.m
//  PinTest
//
//  Created by Orlando Schäfer on 25/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinFormatterHelper.h"

@implementation ACSPinFormatterHelper


+ (NSString*)secure4DigitsPasscodeStringForString:(NSString *)string
{

    if (string.length == 0 || !string) {
        return @"○  ○  ○  ○";
    }

    NSString *passcodeString = @"";
    for (int i = 0; i < string.length; i++) {
        passcodeString = [passcodeString stringByAppendingString:@"●  "];
    }

    NSInteger nonNumbersCount = 4 - string.length;

    for (int j = 0; j < nonNumbersCount; j++) {
        passcodeString = [passcodeString stringByAppendingString:@"○  "];
    }

    passcodeString = [passcodeString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    return passcodeString;

}



+ (NSString *)numberStringFromInteger:(NSUInteger)integer
{
    NSString *numberString = [NSString stringWithFormat:@"%ld", (long)integer];
    return numberString;
}

+ (NSUInteger)integerFromNumberString:(NSString *)numberString
{
    NSUInteger integer = [numberString integerValue];
    return integer;
}

@end
