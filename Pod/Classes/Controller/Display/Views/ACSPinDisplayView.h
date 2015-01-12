//
//  ACSPinDisplayView.h
//  PinTest
//
//  Created by Orlando Schäfer on 16/12/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACSPinDisplayView : UIView

- (void)setupViews;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UILabel *passcodeLabel;
@property (strong, nonatomic) UILabel *alertLabel;

@end
