//
//  ACSPinAnimationHelper.h
//  PinTest
//
//  Created by Orlando Schäfer on 25/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ACSPinAnimationHelper : NSObject

+ (void)animateLeftOutRightInWithLabel:(UILabel *)label updateBlock:(void (^)(void))updateBlock completion:(void (^)(void))completion;

+ (void)animateFadeInTextForLabel:(UILabel *)label withString:(NSString *)string updateBlock:(void (^)(void))updateBlock completion:(void (^)(void))completion;

+ (void)animateBouncingWithPasscodeLabel:(UILabel *)label updateBlock:(void (^)(void))updateBlock completion:(void (^)(void))completion;
@end
