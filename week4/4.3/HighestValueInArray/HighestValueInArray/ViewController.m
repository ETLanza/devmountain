//
//  ViewController.m
//  HighestValueInArray
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@10000, @9, @77777, @789, @678, @6];
    
    NSNumber *max = [array valueForKeyPath:@"@max.self"];
    NSLog(@"%@", max);
    
    [self highestValueInArray:array];

}

- (void)highestValueInArray:(NSArray *)array
{
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
    {
        return obj1 < obj2;
    }];
    
    NSLog(@"%@", sortedArray);
    NSLog(@"Highest value: %@", sortedArray[0]);
    NSLog(@"Second highest value: %@", sortedArray[1]);
}


@end
