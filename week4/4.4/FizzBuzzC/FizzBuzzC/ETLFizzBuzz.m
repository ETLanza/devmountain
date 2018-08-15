//
//  ETLFizzBuzz.m
//  FizzBuzzC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLFizzBuzz.h"

@implementation ETLFizzBuzz


+ (void)fizzBuzzTo:(NSInteger)fizzBuzzCounter

{
    for (int i = 1; i <= fizzBuzzCounter; i++ ){
        if (i % 3 == 0 && i % 5 == 0)
        {
            printf("FizzBuzz\n");
        } else if (i % 3 == 0) {
            printf("Fizz\n");
        } else if (i % 5 == 0) {
            printf("Buzz\n");
        } else {
            printf("%i\n", i);
        }
    }
}

+ (NSArray *)createFibonacciArray
{
    NSMutableArray *fibArray = [[NSMutableArray alloc] init];
    
    [fibArray addObject:@1];
    [fibArray addObject:@1];
    
    int i = 0;
    while (i < 44) {
        i++;
        NSUInteger firstIndex = fibArray.count - 2;
        NSUInteger secondIndex = fibArray.count - 1;
        NSNumber *firstNumberToAdd = fibArray[firstIndex];
        NSNumber *secondNumberToAdd = fibArray[secondIndex];
        NSInteger finalNumberToAppend = [firstNumberToAdd intValue] + [secondNumberToAdd intValue];
        [fibArray addObject:@(finalNumberToAppend)];
    }
    return fibArray;
}

+ (void)fibonacciSequenceFor:(NSInteger)fibonacci
{


}

@end
