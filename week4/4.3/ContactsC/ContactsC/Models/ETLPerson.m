//
//  ETLPerson.m
//  ContactsC
//
//  Created by Eric Lanza on 7/25/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLPerson.h"

@implementation ETLPerson

- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _phoneNumber = [phoneNumber copy];
    }
    return self;
}

-(void)dealloc
{
    [_name release];
    [_phoneNumber release];
    [super dealloc];
}

@end
