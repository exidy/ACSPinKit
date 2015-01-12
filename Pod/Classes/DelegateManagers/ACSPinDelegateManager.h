//
// Created by Orlando Schäfer on 18/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACSKeychainHelper.h"
#import "ACSPinControllerDelegate.h"


@protocol ACSPinControllerDelegate;
@class ACSKeychainHelper;
@class ACSPinVerifyDelegateManager;
@class ACSPinCreateDelegateManager;
@class ACSPinChangeDelegateManager;


@interface ACSPinDelegateManager : NSObject

@property (nonatomic, weak) id <ACSPinControllerDelegate> pinControllerDelegate;
@property (nonatomic, strong) ACSKeychainHelper *keychainHelper;

@property (nonatomic, strong) ACSPinChangeDelegateManager *pinChangeDelegateManager;
@property (nonatomic, strong) ACSPinCreateDelegateManager *pinCreateDelegateManager;
@property (nonatomic, strong) ACSPinVerifyDelegateManager *pinVerifyDelegateManager;

@property (nonatomic) NSUInteger retriesMax;
- (NSString *)storedPin;
- (BOOL)resetPIN;

@end