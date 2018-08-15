//
//  IDontRememberHowToDoThis.m
//  LongestWordC
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "IDontRememberHowToDoThis.h"

@implementation IDontRememberHowToDoThis

+(NSString *) longestWordC:(NSString *)string {
    
    NSArray *array = [string componentsSeparatedByString:@" "];
    
    NSString *word = @"";
    
    for (NSString *string in array) {
        if ([string length] > [word length]) {
            word = string;
        }
    }
    
    return word;
}

+(void)palindrome:(NSString *)string {
    
    NSArray *array = [string componentsSeparatedByString:@" "];
    
    int counter = 0;
    NSString *word = array[counter];
    counter ++;
    self palindrome:word
    
    
}


@end
