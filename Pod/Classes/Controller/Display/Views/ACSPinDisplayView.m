//
//  ACSPinDisplayView.m
//  PinTest
//
//  Created by Orlando Schäfer on 16/12/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinDisplayView.h"

@implementation ACSPinDisplayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }

    return self;
}

- (void)setupViews
{
    self.imageView = [[UIImageView alloc] init];
    self.headerLabel = [[UILabel alloc] init];
    self.passcodeLabel = [[UILabel alloc] init];
    self.passcodeLabel.font = [UIFont fontWithName:@"Menlo-Regular" size:25.0];
    self.alertLabel = [[UILabel alloc] init];

    
    NSArray *views = @[self.imageView, self.headerLabel, self.passcodeLabel, self.alertLabel];
    NSArray *labels = @[self.headerLabel, self.passcodeLabel, self.alertLabel];
    
    for (UIView *view in views) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
    }
    for (UILabel *label in labels) {
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
    }
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSDictionary *views = @{
                            @"imageView" : self.imageView,
                            @"headerLabel" : self.headerLabel,
                            @"passcodeLabel" : self.passcodeLabel,
                            @"alertLabel" : self.alertLabel
                            };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[imageView]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[headerLabel]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[passcodeLabel]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[alertLabel]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passcodeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView(<=20)]-[headerLabel]-[passcodeLabel]-[alertLabel]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    

}

@end
