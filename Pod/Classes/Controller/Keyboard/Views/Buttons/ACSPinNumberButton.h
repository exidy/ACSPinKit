//
//  ACSPinNumberButton.h
//  PinTest
//
//  Created by Orlando Schäfer on 12/12/14.
//
//

#import <UIKit/UIKit.h>
#import "ACSPinNumberPadItem.h"


@interface ACSPinNumberButton : UIButton <ACSPinNumberPadItem>

@property (nonatomic, readonly) NSString *value;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, strong) UIColor *backColor;

@end
