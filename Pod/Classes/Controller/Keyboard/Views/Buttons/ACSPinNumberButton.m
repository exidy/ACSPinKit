//
//  ACSPinNumberButton.m
//  PinTest
//
//  Created by Orlando Schäfer on 12/12/14.
//
//

#import "ACSPinNumberButton.h"
#import "ACSPinNumberPadItem.h"


@interface ACSPinNumberButton ()

@property (nonatomic) NSString *value;

@end

@implementation ACSPinNumberButton

- (void)setValue:(NSString *)value withTitle:(NSString *)title andSubtitle:(NSString *)subtitle
{
    self.value = value;

    title = [title stringByAppendingString:@"\n"];
    NSMutableAttributedString *totalString = [[NSMutableAttributedString alloc] initWithString:title attributes:[self attributesForTitle]];
    NSMutableAttributedString *subtitleString = [[NSMutableAttributedString alloc] initWithString:subtitle attributes:[self attributesForSubtitle]];
    [totalString appendAttributedString:subtitleString];

    [self setAttributedTitle:totalString forState:UIControlStateNormal];

    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.minimumScaleFactor = 0.5;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setValue:(NSString *)value withTitle:(NSString *)title
{
    self.value = value;

    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:title attributes:[self attributesForTitle]];

    [self setAttributedTitle:titleString forState:UIControlStateNormal];

    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.minimumScaleFactor = 0.5;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (NSDictionary *)attributesForTitle
{
    return @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],
            NSForegroundColorAttributeName : self.titleColor};
}

- (NSDictionary *)attributesForSubtitle
{
    return @{NSFontAttributeName : [UIFont systemFontOfSize:8],
            NSForegroundColorAttributeName : self.titleColor};
}


- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];

    UIColor *newColor = highlighted ? self.highlightColor : self.backColor;

    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.backgroundColor = newColor;
    } completion:nil];
}


@end
