//
//  ViewController.m
//  ReverseArray
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arrayToSort = @[@1, @2, @3, @4];
    NSLog(@"This is the array to reverse %@", arrayToSort);

    NSArray *sortedArray = [[NSArray alloc] init];
    sortedArray = [self reverseArray:arrayToSort];
    NSLog(@"This is the reveresed array %@",sortedArray);
    
}

- (NSArray *)reverseArray:(NSArray *)array
{
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    for (NSUInteger i = [array count] ; i > 0; i-- )
    {
        [newArray addObject:[array objectAtIndex:(i - 1)]];
    }
    return newArray;
}

@end
