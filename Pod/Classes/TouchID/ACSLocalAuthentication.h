

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>


@class ACSLocalAuthentication;

@protocol ACSLocalAuthenticationDelegate <NSObject>

@required

- (void)localAuthenticationAuthenticatedSuccessfully:(ACSLocalAuthentication *)localAuthentication;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication failedWithError:(NSError *)error;

@optional

- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication authenticationFailed:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication userCancelled:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication systemCancelled:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication userFallback:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication touchIDNotEnrolled:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication touchIDNotAvailable:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication passcodeNotSet:(NSError *)error;

@end


@interface ACSLocalAuthentication : NSObject

/**
* The delegate object that implements the ACSLocalAuthenticationDelegate
*/
@property (nonatomic, weak) id <ACSLocalAuthenticationDelegate> delegate;

/**
* The string which is presented to the user in the authentication dialog
*/
@property (nonatomic, copy) NSString *reasonText;

/**
* Fallback button title. Allows fallback button title customization. A default title "Enter Password" is used when
* this property is left nil. If set to empty string, the button will be hidden.
*/
@property (nonatomic, copy) NSString *fallbackButtonTitle;

/**
* Set desired policy. Currently only 'LAPolicyDeviceOwnerAuthenticationWithBiometrics' is available
*/
@property (nonatomic, assign) LAPolicy policy;

/**
* Evaluates if user and device can use Touch ID.
*
* @param error On input, a pointer to an error object. If Touch ID is not available,
* this pointer is set to an actual error object containing the error information (inspect LAError in the code property).
* You may specify nil for this parameter if you do not want the error information.
*
* @return YES if Touch ID is available for the user and device, NO otherwise
*
*/
+ (BOOL)biometricsAuthenticationAvailable:(NSError **) error;

/**
* Evaluates the policy set. For Touch ID this means, the user is prompted to verify its biometrics (if possible).
* This method triggers callbacks defined in the ACSLocalAuthenticationDelegate
*
* @see ACSLocalAuthenticationDelegate
*/
- (void)authenticate;

@end
