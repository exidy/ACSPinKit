//
// Created by Orlando Schäfer on 19/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ACSPinNumberPadItem <NSObject>

- (void)setValue:(NSString *)value withTitle:(NSString *)title andSubtitle:(NSString *)subtitle;

- (void)setValue:(NSString *)value withTitle:(NSString *)title;

- (NSString *)value;

@end