//
//  ACSKeychainHelper.m
//  PinTest
//
//  Created by Orlando Schäfer on 06/12/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSKeychainHelper.h"
#import "ACSKeychainUtils.h"
#import "ACSPinFormatterHelper.h"


@interface ACSKeychainHelper ()

@property (nonatomic, copy) NSString *pinServiceName;
@property (nonatomic, copy) NSString *pinUserName;

@property (nonatomic, copy) NSString *pinRetriesMaxName;
@property (nonatomic, copy) NSString *pinRetriesCountName;
@end


@implementation ACSKeychainHelper

- (instancetype)initWithPinServiceName:(NSString *)pinServiceName andPinUserName:(NSString *)pinUserName
{

    self = [super init];
    if (self) {
        
        NSAssert(pinServiceName.length > 0, @"ACSKeychainHelper initialization: Parameter 'pinServiceName' must not be nil!");
        NSAssert(pinUserName.length > 0, @"ACSKeychainHelper initialization: Parameter 'pinUserName' must not be nil!");
        
        self.pinServiceName = pinServiceName;
        self.pinUserName = pinUserName;
        self.pinRetriesMaxName = [self.pinUserName stringByAppendingString:@"_pinRetriesMax"];
        self.pinRetriesCountName = [self.pinUserName stringByAppendingString:@"_pinRetriesCount"];
    }
    return self;
}

#pragma mark - PIN Management

- (BOOL)savePin:(NSString *)pin
{
    NSError *error;
    [ACSKeychainUtils storeUsername:self.pinUserName
                        andPassword:pin
                     forServiceName:self.pinServiceName
                     updateExisting:YES
                              error:&error];
    return error == nil;
}

- (BOOL)resetPin
{
    NSError *error;
    [ACSKeychainUtils deleteItemForUsername:self.pinUserName
                             andServiceName:self.pinServiceName
                                      error:&error];
    return error == nil;
}

- (NSString *)savedPin
{
    NSError *error;
    NSString *pin = [ACSKeychainUtils getPasswordForUsername:self.pinUserName
                                              andServiceName:self.pinServiceName
                                                       error:&error];

    return error ? nil : pin;
}

#pragma mark - Retries Management

- (BOOL)saveRetriesMax:(NSUInteger)retriesMax
{
    NSString *retriesMaxString = [ACSPinFormatterHelper numberStringFromInteger:retriesMax];
    NSError *error;
    [ACSKeychainUtils storeUsername:self.pinRetriesMaxName
                        andPassword:retriesMaxString
                     forServiceName:self.pinServiceName
                     updateExisting:YES
                              error:&error];
    return error == nil;
}

- (NSUInteger)retriesMax
{
    NSError *error = nil;
    NSString *currentMaxString = [ACSKeychainUtils getPasswordForUsername:self.pinRetriesMaxName
                                                           andServiceName:self.pinServiceName
                                                                    error:&error];

    
    return error ? NSNotFound : [ACSPinFormatterHelper integerFromNumberString:currentMaxString];

}

- (BOOL)incrementRetryCount
{
    // Default value, if we don't have a current count, is 1.
    NSString *newCountString = @"1";
    NSString *currentCountString = [ACSKeychainUtils getPasswordForUsername:self.pinRetriesCountName
                                                             andServiceName:self.pinServiceName
                                                                      error:nil];
    // If we have a current value, reset the default value
    if (currentCountString.length > 0) {
        NSUInteger currentCount = [ACSPinFormatterHelper integerFromNumberString:currentCountString];
        NSUInteger newCount = currentCount + 1;
        newCountString = [ACSPinFormatterHelper numberStringFromInteger:newCount];
    }

    // Save the new count...
    NSError *error;
    [ACSKeychainUtils storeUsername:self.pinRetriesCountName
                        andPassword:newCountString
                     forServiceName:self.pinServiceName
                     updateExisting:YES
                              error:&error];
    return error == nil;
}

- (NSUInteger)retriesToGoCount
{
    NSString *currentCountString = [ACSKeychainUtils getPasswordForUsername:self.pinRetriesCountName
                                                             andServiceName:self.pinServiceName
                                                                      error:nil];
    NSString *currentMaxString = [ACSKeychainUtils getPasswordForUsername:self.pinRetriesMaxName
                                                           andServiceName:self.pinServiceName
                                                                    error:nil];
    if (!currentMaxString.length > 0) {
        NSException* noMaxException = [NSException exceptionWithName:@"ACSKeychainHelperException"
                                                              reason:@"No Retry max count saved"
                                                            userInfo:nil];
        [noMaxException raise];
    }
    
    if (!currentCountString.length > 0) {
        return [ACSPinFormatterHelper integerFromNumberString:currentMaxString];
    }
    
    NSUInteger maxCount = [ACSPinFormatterHelper integerFromNumberString:currentMaxString];
    NSUInteger currentCount = [ACSPinFormatterHelper integerFromNumberString:currentCountString];
    
    return maxCount - currentCount;
    
}

- (BOOL)resetRetriesToGoCount
{
    NSError *error;
    [ACSKeychainUtils storeUsername:self.pinRetriesCountName
                        andPassword:@"0"
                     forServiceName:self.pinServiceName
                     updateExisting:YES
                              error:&error];
    return error == nil;
}

@end
