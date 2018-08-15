//
//  main.m
//  FizzBuzzC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETLFizzBuzz.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        [ETLFizzBuzz fizzBuzzTo:100];
        NSArray *fibArray = [ETLFizzBuzz createFibonacciArray];
        NSLog(@"%@", fibArray);
    }
    return 0;
}
