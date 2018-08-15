//
//  EntryController.m
//  Journal_ObjC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLEntryController.h"

@interface ETLEntryController()

@property (nonatomic, strong, readwrite) NSMutableArray *internalEntries;

@end

@implementation ETLEntryController

-(NSArray *)entries { return self.internalEntries; }

+ (ETLEntryController *)sharedController
{
    static ETLEntryController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [ETLEntryController new];
    });
    return sharedController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalEntries = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)addEntry:(ETLEntry *)entry
{
    [self.internalEntries addObject:entry];
}

- (void)removeEntry:(ETLEntry *)entry
{
    [self.internalEntries removeObject:entry];

}

- (void)updateEntry:(ETLEntry *)entry withTitle:(NSString *)title andBodyText:(NSString *)bodyText
{
    [entry setTitle:title];
    [entry setBodyText:bodyText];
}

@end
