//
//  ACSPinAnimationHelper.m
//  PinTest
//
//  Created by Orlando Schäfer on 25/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinAnimationHelper.h"


@implementation ACSPinAnimationHelper

+ (void)animateLeftOutRightInWithLabel:(UILabel *)label updateBlock:(void (^)(void))updateBlock completion:(void (^)(void))completion
{
    [UIView animateWithDuration:0.3 animations:^{

        label.transform = CGAffineTransformMakeTranslation(-1000, 0);

    } completion:^(BOOL finishedLeft) {

        label.transform = CGAffineTransformMakeTranslation(2000, 0);
        
        if (updateBlock) {
            updateBlock();
        }

        [UIView animateWithDuration:0.3 animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finishedRight) {

            if (completion) {
                completion();
            }

        }];
    }];
}

+ (void)animateFadeInTextForLabel:(UILabel *)label withString:(NSString *)string updateBlock:(void (^)(void))updateBlock completion:(void (^)(void))completion
{
    [UIView animateWithDuration:0.3 animations:^{

        label.alpha = 0.0;

    } completion:^(BOOL finishedFadeOut) {

        label.text = string;
        
        if (updateBlock) {
            updateBlock();
        }

        [UIView animateWithDuration:0.3 animations:^{
            label.alpha = 1.0;
        } completion:^(BOOL finishedFadeIn) {

            if (completion) {
                completion();
            }
        }];
    }];
}

+ (void)animateBouncingWithPasscodeLabel:(UILabel *)label updateBlock:(void (^)(void))updateBlock completion:(void (^)(void))completion
{
    label.transform = CGAffineTransformMakeTranslation(-40, 0);
    
    [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (updateBlock) {
                updateBlock();
            }
        });
        
        label.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];


}

@end
