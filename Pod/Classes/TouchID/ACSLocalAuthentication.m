

#import "ACSLocalAuthentication.h"

@interface ACSLocalAuthentication ()

@property (nonatomic, strong) LAContext * context;

@end

@implementation ACSLocalAuthentication


- (instancetype)init {

    if (self = [super init]) {

        self.context = [[LAContext alloc] init];

        // Set defaults
        self.fallbackButtonTitle = nil;
        self.reasonText = @"Authentication needed.";
        self.policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;

    }
    return self;
}

#pragma mark - Public

+ (BOOL)biometricsAuthenticationAvailable:(NSError **) error
{
    // Local authentication framework available? Just proceed when there is a class named 'LAContext'.
    if ([NSClassFromString(@"LAContext") class]) {
        LAContext *context = [[LAContext alloc] init];
        return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:error];
    }
    return NO;
}

- (void)authenticate
{
    self.context = [[LAContext alloc] init];
    self.context.localizedFallbackTitle = self.fallbackButtonTitle;

    NSError *authError = nil;

    if ([self.context canEvaluatePolicy:self.policy error:&authError]) {

        [self.context evaluatePolicy:self.policy localizedReason:self.reasonText reply:^(BOOL authenticated, NSError *error) {

            if (authenticated) {

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate localAuthenticationAuthenticatedSuccessfully:self];
                });


            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.delegate localAuthentication:self failedWithError:error];
                    [self inspectError:error];
                });
            }
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.delegate localAuthentication:self failedWithError:authError];
            [self inspectError:authError];
        });
    }
}

#pragma mark - Private

- (void)inspectError:(NSError *)error
{
    switch (error.code) {
        case LAErrorAuthenticationFailed:
            if ([self.delegate respondsToSelector:@selector(localAuthentication:authenticationFailed:)]) {
                [self.delegate localAuthentication:self authenticationFailed:error];
            }
            break;
        case LAErrorUserCancel:
            if ([self.delegate respondsToSelector:@selector(localAuthentication:userCancelled:)]) {
                [self.delegate localAuthentication:self userCancelled:error];
            }
            break;
        case LAErrorSystemCancel:
            if ([self.delegate respondsToSelector:@selector(localAuthentication:systemCancelled:)]) {
                [self.delegate localAuthentication:self systemCancelled:error];
            }
            break;
        case LAErrorUserFallback:
            if ([self.delegate respondsToSelector:@selector(localAuthentication:userFallback:)]) {
                [self.delegate localAuthentication:self userFallback:error];
            }
            break;
        case LAErrorTouchIDNotAvailable:
            if ([self.delegate respondsToSelector:@selector(localAuthentication:touchIDNotAvailable:)]) {
                [self.delegate localAuthentication:self touchIDNotAvailable:error];
            }
            break;
        case LAErrorTouchIDNotEnrolled:
            if ([self.delegate respondsToSelector:@selector(localAuthentication:touchIDNotEnrolled:)]) {
                [self.delegate localAuthentication:self touchIDNotEnrolled:error];
            }
            break;
        case LAErrorPasscodeNotSet:
            if ([self.delegate respondsToSelector:@selector(localAuthentication:passcodeNotSet:)]) {
                [self.delegate localAuthentication:self passcodeNotSet:error];
            }
            break;
        default:
            break;
    }
}

@end
