//
//  ACSPinDisplayController.h
//  PinTest
//
//  Created by Orlando Schäfer on 26/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSPinDisplay.h"

@class ACSPinDisplayView;


@interface ACSPinDisplayController : UIViewController <ACSPinDisplay>

@property (nonatomic, strong) ACSPinDisplayView *displayView;

@end
