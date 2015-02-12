//
//  ACSPinCreateController.m
//  PinTest
//
//  Created by Orlando Schäfer on 26/11/14.
//  Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinCreateController.h"
#import "ACSPinKeyboard.h"
#import "ACSPinDisplay.h"
#import "ACSI18NHelper.h"


@interface ACSPinCreateController ()

@property (nonatomic) BOOL isRepeating;
@property (nonatomic) NSString *stringEnteredInitially;

@end

@implementation ACSPinCreateController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:ACSI18NString(kACSButtonCancelTitle)
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(didSelectCancelButtonItem:)];
    self.navigationItem.leftBarButtonItem = barButtonItem;

    [self addChildControllers];
    self.view.backgroundColor = self.displayController.view.backgroundColor;
    self.isRepeating = NO;
    [self.displayController updateHeaderLabelWithString:ACSI18NString(kACSCreateHeaderInitialText)];

}

- (void)didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem
{
    [self.pinCreateDelegate pinCreateController:self didSelectCancelButtonItem:cancelButtonItem];
}

- (void)addChildControllers
{

    [self addChildViewController:self.keyboardController];
    [self.view addSubview:self.keyboardController.view];
    [self.keyboardController didMoveToParentViewController:self];

    [self addChildViewController:self.displayController];
    [self.view addSubview:self.displayController.view];
    [self.displayController didMoveToParentViewController:self];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[display]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"display":self.displayController.view}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[keyboard]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"keyboard":self.keyboardController.view}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][display][keyboard(==display)]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"top":self.topLayoutGuide, @"display":self.displayController.view, @"keyboard":self.keyboardController.view}]];
    
}


#pragma mark - Pin keyboard controller delegate

- (void)pinKeyboardController:(UIViewController <ACSPinKeyboard> *)pinKeyboardController didEnterCharacter:(NSString *)character textString:(NSString *)textString
{
    [self.displayController updatePasscodeLabelWithString:textString];
}

- (void)pinKeyboardController:(UIViewController <ACSPinKeyboard> *)pinKeyboardController didFinishEnteringText:(NSString *)textString
{
    [self.keyboardController reset];

    // First entering of PIN...
    if (!self.isRepeating) {
        [self setupForRepeatingPinWithEnteredPin:textString];
    }
    // Repeating PIN case...validate if its the same PIN again!
    else {
        [self validateRepeatedPin:textString];
    }
}

- (void)pinKeyboardController:(UIViewController <ACSPinKeyboard> *)pinKeyboardController didResetText:(NSString *)textString
{
    [self.displayController updatePasscodeLabelWithString:textString];
}

#pragma - Validation or Repeat

- (void)validateRepeatedPin:(NSString *)pin
{
    // Creation is successful!
    if ([self.stringEnteredInitially isEqualToString:pin]) {

        [self.pinCreateDelegate pinCreateController:self didCreatePIN:pin];
    }
    // Two PINs are not equal. We transition to the beginning state...
    else {
        self.stringEnteredInitially = nil;
        self.isRepeating = NO;
        [self.displayController updateHeaderLabelWithString:ACSI18NString(kACSCreateHeaderInitialText)];
        [self.displayController animateForErrorWithAlertString:ACSI18NString(kACSCreateAlertText) completion:nil];
    }
}

- (void)setupForRepeatingPinWithEnteredPin:(NSString *)pin
{
    self.stringEnteredInitially = pin;
    self.isRepeating = YES;
    [self.displayController animateForRepetitionWithHeaderString:ACSI18NString(kACSCreateHeaderRepeatText) withCompletion:nil];
}


@end
