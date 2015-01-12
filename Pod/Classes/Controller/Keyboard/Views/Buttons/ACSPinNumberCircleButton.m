//
// Created by Orlando Schäfer on 19/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinNumberCircleButton.h"


@implementation ACSPinNumberCircleButton

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];

    if (!self.hideCircle) {

        CGFloat radius = CGRectGetMidX(self.bounds);
        self.layer.cornerRadius = radius;
        self.layer.borderWidth = 1;
        self.layer.borderColor = self.titleColor.CGColor;
        self.clipsToBounds = YES;
    }
}

- (void)setValue:(NSString *)value withTitle:(NSString *)title {

    [super setValue:value withTitle:title];
    
    // If we hide the circle border for this button we need to indicate highlighting on a different way. We reapply the
    // attributes for the normal state from superclass for the highlight state (with a lighter text color).
    if (self.hideCircle) {
        
        NSAttributedString *attributedTitleString = [self attributedTitleForState:UIControlStateNormal];
        NSDictionary *attributes = [attributedTitleString attributesAtIndex:0 effectiveRange:NULL];
        NSMutableDictionary *mutableAttributes = [attributes mutableCopy];
        UIColor *highlightColor = mutableAttributes[NSForegroundColorAttributeName];
        mutableAttributes[NSForegroundColorAttributeName] = [highlightColor colorWithAlphaComponent:0.5];
        
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:title attributes:mutableAttributes];
        [self setAttributedTitle:titleString forState:UIControlStateHighlighted];
    }
    
    
}

@end