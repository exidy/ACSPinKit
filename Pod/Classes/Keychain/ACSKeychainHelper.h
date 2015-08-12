//
//  ACSKeychainHelper.h
//  PinTest
//
//  Created by Orlando Schäfer on 06/12/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACSKeychainHelper : NSObject

- (instancetype)initWithPinServiceName:(NSString *)pinServiceName pinUserName:(NSString *)pinUserName accessGroup:(NSString *)accessGroup;

// PIN Management
- (BOOL)savePin:(NSString *)pin;
- (BOOL)resetPin;
- (NSString *)savedPin;

// Retries Management
- (BOOL)saveRetriesMax:(NSUInteger)retriesMax;
- (NSUInteger)retriesMax;

- (BOOL)incrementRetryCount;
- (NSUInteger)retriesToGoCount;
- (BOOL)resetRetriesToGoCount;


@end
