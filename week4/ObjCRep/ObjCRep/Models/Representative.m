//
//  Representative.m
//  ObjCRep
//
//  Created by Eric Lanza on 8/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "Representative.h"

@implementation Representative

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

@end
