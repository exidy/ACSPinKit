//
//  ACSPinDisplayFullscreenView.m
//  PinTest
//
//  Created by Orlando Schäfer on 08/01/15.
//  Copyright (c) 2015 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinDisplayFullscreenView.h"

@implementation ACSPinDisplayFullscreenView

- (void)setupViews
{

    [super setupViews];
    
    self.alertLabel.hidden = YES;
    
}
- (void)updateConstraints
{
    [super updateConstraints];
    
    [self removeConstraints:self.constraints];
    
    NSDictionary *views = @{
                            @"imageView" : self.imageView,
                            @"headerLabel" : self.headerLabel,
                            @"passcodeLabel" : self.passcodeLabel
                            };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[imageView]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[headerLabel]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[passcodeLabel]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=8)-[imageView(<=30)]-(8)-[headerLabel]-(8)-[passcodeLabel]-(>=8)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    
    
}

@end
