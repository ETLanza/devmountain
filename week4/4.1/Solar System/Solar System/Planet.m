//
//  Planet.m
//  Solar System
//
//  Created by Eric Lanza on 7/21/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "Planet.h"

@implementation Planet

- (instancetype)initWithName:(NSString *)name diameter:(NSInteger)diameter dayLength:(float)dayLength millionKMsFromSun:(float)millionKMsFromSun
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _imageName = [name lowercaseString];
        _diameter = diameter;
        _dayLength = dayLength;
        _millionKMsFromSun = millionKMsFromSun;
    }
    return self;
}

@end
