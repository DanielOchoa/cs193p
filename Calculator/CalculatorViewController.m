//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Daniel Ochoa on 12/2/12.
//  Copyright (c) 2012 Daniel Ochoa. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber, alreadyDecimal;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize secondDisplay = _secondDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize alreadyDecimal = _alreadyDecimal;
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc]init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    // if decimal already exists do nothing //
    if (self.alreadyDecimal && [digit isEqualToString:@"."]) return;
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    if ([digit isEqualToString:@"."]) self.alreadyDecimal = YES;
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.alreadyDecimal = NO;
    
    if ([self.secondDisplay.text isEqualToString:@"0"]) {
        self.secondDisplay.text = self.display.text;
    } else {
        self.secondDisplay.text = [self.secondDisplay.text stringByAppendingFormat:@" %@", self.display.text];
    }
}


- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = sender.currentTitle;
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    self.secondDisplay.text = [self.secondDisplay.text stringByAppendingFormat:@" %@ =", operation];
}

- (IBAction)clear {
    self.display.text = @"0";
    self.secondDisplay.text = @"0";
    [self.brain clearBrain];
}

- (IBAction)backspace {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
    } 
}

- (IBAction)changeSign {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        double changer = [self.display.text doubleValue] * -1;
        self.display.text = [NSString stringWithFormat:@"%g", changer];
    } else {
        self.display.text = [NSString stringWithFormat:@"%g", [self.display.text doubleValue] * -1];
        [self enterPressed];
    }
}


@end
