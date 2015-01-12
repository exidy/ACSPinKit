//
// Created by Orlando Schäfer on 17/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ACSPinDisplay <NSObject>

@required

- (void)updatePasscodeLabelWithString:(NSString *)string;
- (void)updateHeaderLabelWithString:(NSString *)string;
- (void)updateAlertLabelWithString:(NSString *)string;

- (void)animateForErrorWithAlertString:(NSString *)alertString completion:(void (^)(void))completion;
- (void)animateForRepetitionWithHeaderString:(NSString *)string withCompletion:(void (^)(void))completion;

@end