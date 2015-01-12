//
// Created by Orlando Schäfer on 18/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinVerifyFullscreenController.h"

@interface ACSPinVerifyFullscreenController()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation ACSPinVerifyFullscreenController


- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.actionButton) {
        [self addActionButton];
    }
}

- (void)addActionButton
{
    self.actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.actionButton addTarget:self action:@selector(didSelectActionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.actionButton];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button]-(8)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"button" : self.actionButton}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][button]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"top" : self.topLayoutGuide, @"button" : self.actionButton}]];
    
    if (self.actionButton.imageView.image) {
        self.actionButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(==30)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"button" : self.actionButton}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(==30)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"button" : self.actionButton}]];
    }
    
}

- (void)didSelectActionButton:(UIButton *)actionButton
{
    [self.pinVerifyDelegate pinVerifyController:self didSelectActionButton:actionButton];
}

- (void)addChildControllers
{
    self.containerView = [[UIView alloc] init];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.keyboardController.view];
    [self.containerView addSubview:self.displayController.view];

    // We want that the container is centered on big screens (iPad) but it should spread to all edges on small screens (iPhone)
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:self.topLayoutGuide.length];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:647.0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:375.0];

    top.priority = 998;
    left.priority = 998;
    right.priority = 998;
    bottom.priority = 998;
    centerX.priority = 990;
    centerY.priority = 990;
    height.priority = UILayoutPriorityRequired;
    width.priority = UILayoutPriorityRequired;

    [self.view addConstraints:@[top, left, right, bottom, centerX, centerY]];
    [self.containerView addConstraints:@[height, width]];

    // Layout display and keyboard in the container view
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[display]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"display":self.displayController.view}]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[keyboard]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"keyboard":self.keyboardController.view}]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[display][keyboard]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"display":self.displayController.view, @"keyboard":self.keyboardController.view}]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.keyboardController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.7 constant:0.0]];

}

//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}

@end