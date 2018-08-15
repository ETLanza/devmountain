//
//  ETLPersonController.m
//  ContactsC
//
//  Created by Eric Lanza on 7/25/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLPersonController.h"

@interface ETLPersonController()


@property (nonatomic, retain) NSMutableArray *internalPeople;

@end

@implementation ETLPersonController

-(instancetype) init
{
    self = [super init];
    if (self) {
        _internalPeople = [NSMutableArray new];
    }
    return self;
}

+ (instancetype)sharedController
{
    static ETLPersonController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [ETLPersonController new];
    });
    return sharedController;
}

-(NSArray *)people { return [[self.internalPeople copy] autorelease]; }

#pragma mark - CRUD functions
- (void)addPerson:(ETLPerson *)person
{
    [self.internalPeople addObject:person];
}

- (void)deletePerson:(ETLPerson *)person
{
    [self.internalPeople removeObject:person];
}

#pragma mark - Dealloc
- (void)dealloc
{
    NSLog(@"internalPeople dealloc");
    [_internalPeople release];
    [super dealloc];
}
@end
