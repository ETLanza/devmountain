//
//  DMNPerson.m
//  ObjC
//
//  Created by Eric Lanza on 7/21/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "DMNPerson.h"

@implementation DMNPerson

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age height:(float)height
{
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
        _height = height;
    }
    return self;
}

-(void)sayYourName
{
    NSLog(@"My name is so-and-so.");
}

+ (float)averageHeight
{
    return 6.0;
}

- (void)eatFoot:(NSString *)food
{
    NSLog(@"That %@ was delicious", food);
}

- (void)driveCar:(id)car to:(NSString *)location bringingAlong:(DMNPerson *)person
{
    NSLog(@"I'm going to %@ in my %@, with %@.", location, car, person);
}

@end
