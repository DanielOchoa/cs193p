//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Daniel Ochoa on 12/2/12.
//  Copyright (c) 2012 Daniel Ochoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void) pushOperand:(double)operand;
-(double) performOperation:(NSString *)operation;
-(void) clearBrain;

@property (readonly) id program;

+(double)runProgram:(id)program;
+(NSString *)descriptionOfProgram:(id)program;
 
@end
