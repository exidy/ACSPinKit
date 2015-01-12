//
// Created by Orlando Schäfer on 16/12/14.
// Copyright (c) 2014 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ACSPinNumberPadView.h"
#import "ACSPinNumberButton.h"
#import "ACSPinNumberPadItem.h"


@interface ACSPinNumberPadView()

@property (nonatomic, strong) ACSPinNumberButton *buttonEmpty;

@end

@implementation ACSPinNumberPadView


- (instancetype)initWithBackgroundColor:(UIColor*)backgroundColor buttonTintColor:(UIColor *)buttonTintColor buttonTitleColor:(UIColor *)buttonTitleColor buttonHighlightColor:(UIColor *)buttonHighlightColor
{
    self = [super init];
    if (self) {

        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = backgroundColor;
        self.buttonTintColor = buttonTintColor;
        self.buttonTitleColor = buttonTitleColor;
        self.buttonHighlightColor = buttonHighlightColor;
        
        [self setupButtons];
    }

    return self;
} 


- (void)setupButtons
{
    self.button0 = [[ACSPinNumberButton alloc] init];
    self.button1 = [[ACSPinNumberButton alloc] init];
    self.button2 = [[ACSPinNumberButton alloc] init];
    self.button3 = [[ACSPinNumberButton alloc] init];
    self.button4 = [[ACSPinNumberButton alloc] init];
    self.button5 = [[ACSPinNumberButton alloc] init];
    self.button6 = [[ACSPinNumberButton alloc] init];
    self.button7 = [[ACSPinNumberButton alloc] init];
    self.button8 = [[ACSPinNumberButton alloc] init];
    self.button9 = [[ACSPinNumberButton alloc] init];
    self.buttonDelete = [[ACSPinNumberButton alloc] init];
    self.buttonEmpty = [[ACSPinNumberButton alloc] init];

    NSArray *buttonArray = @[self.button0, self.button1, self.button2,
            self.button3, self.button4, self.button5,
            self.button6, self.button7, self.button8,
            self.button9, self.buttonDelete, self.buttonEmpty];

    for (ACSPinNumberButton *button in buttonArray) {

        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.titleColor = self.buttonTitleColor;
        button.highlightColor = self.buttonHighlightColor;
        button.backgroundColor = self.buttonTintColor;
        button.backColor = self.buttonTintColor;
        [self addSubview:button];
    }

}

- (void)updateConstraints
{
    [super updateConstraints];

    // Basic grid layout
    NSString *layout1 = @"V:|-(1)-[button1]-(1)-[button4(==button1)]-(1)-[button7(==button1)]-(1)-[buttonEmpty(==button1)]|";
    NSString *layout2 = @"H:|[button1]-(1)-[button2(==button1)]-(1)-[button3(==button1)]|";
    NSString *layout3 = @"H:|[button4]-(1)-[button5(==button4)]-(1)-[button6(==button4)]|";
    NSString *layout4 = @"H:|[button7]-(1)-[button8(==button7)]-(1)-[button9(==button7)]|";
    NSString *layout5 = @"H:|[buttonEmpty]-(1)-[button0(==buttonEmpty)]-(1)-[buttonDelete(==buttonEmpty)]|";
    
    // Equal heights...
    NSString *layout6 = @"V:[button2(==button1)]";
    NSString *layout7 = @"V:[button3(==button1)]";
    NSString *layout8 = @"V:[button5(==button1)]";
    NSString *layout9 = @"V:[button6(==button1)]";
    NSString *layout10 = @"V:[button8(==button1)]";
    NSString *layout11 = @"V:[button9(==button1)]";
    NSString *layout12 = @"V:[button0(==button1)]";
    NSString *layout13 = @"V:[buttonDelete(==button1)]";
    
    NSArray *leadingToTrailings = @[layout1, layout6, layout7, layout8, layout9, layout10, layout11, layout12, layout13];
    NSArray *alignAllTops = @[layout2, layout3, layout4, layout5];
    
    for (NSString *format in leadingToTrailings) {
        [self setConstraintWithFormat:format options:NSLayoutFormatDirectionLeadingToTrailing];
    }
    for (NSString *format in alignAllTops) {
        [self setConstraintWithFormat:format options:NSLayoutFormatAlignAllTop];
    }

}

- (void)setConstraintWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options
{
    NSDictionary *viewDictionary = [self viewDictionary];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format
                                                                 options:options
                                                                 metrics:nil
                                                                   views:viewDictionary]];
}

- (NSDictionary *)viewDictionary
{
    return @{
            @"button0" : self.button0,
            @"button1" : self.button1,
            @"button2" : self.button2,
            @"button3" : self.button3,
            @"button4" : self.button4,
            @"button5" : self.button5,
            @"button6" : self.button6,
            @"button7" : self.button7,
            @"button8" : self.button8,
            @"button9" : self.button9,
            @"buttonDelete" : self.buttonDelete,
            @"buttonEmpty" : self.buttonEmpty
    };
}


@end