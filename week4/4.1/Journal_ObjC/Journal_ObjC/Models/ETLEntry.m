//
//  Entry.m
//  Journal_ObjC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLEntry.h"

@implementation ETLEntry

- (instancetype)initWithTitle:(NSString *)title bodyText:(NSString *)bodyText
{
    self = [super init];
    if (self) {
        _title = title;
        _bodyText = bodyText;
        _timestamp = [[NSDate alloc] init];
    }
    return self;
}

@end
