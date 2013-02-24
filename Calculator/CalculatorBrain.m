//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Daniel Ochoa on 12/2/12.
//  Copyright (c) 2012 Daniel Ochoa. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack
{
    if(!_operandStack) {
        _operandStack = [[NSMutableArray alloc]init];
    }
    return _operandStack;
}

-(void) pushOperand:(double)operand
{
    NSNumber *operandNumber = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandNumber];
}

-(double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

-(double) performOperation:(NSString *)operation
{
    double result = 0;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double substrasult = [self popOperand];
        result = [self popOperand] - substrasult;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([operation isEqualToString:@"sin"]) {
        double radians = [self popOperand]*M_PI/180;
        result = sin(radians);
    } else if ([operation isEqualToString:@"cos"]) {
        double radians = [self popOperand]*M_PI/180;
        result = cos(radians);
    } else if ([operation isEqualToString:@"sqrt"]) {
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"π"]) {
        result = M_PI;
    }
    
    [self pushOperand:result];
    return result;
}

-(void) clearBrain
{
    [self.operandStack removeAllObjects];
}

@end
