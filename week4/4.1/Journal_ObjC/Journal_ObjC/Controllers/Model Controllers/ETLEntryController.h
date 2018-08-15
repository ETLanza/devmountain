//
//  EntryController.h
//  Journal_ObjC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETLEntry.h"

@class ETLEntry;

@interface ETLEntryController : NSObject

@property (nonatomic, readonly, strong) NSArray* entries;

+(ETLEntryController *) sharedController;

- (void) addEntry:(ETLEntry *)entry;
- (void) removeEntry:(ETLEntry *)entry;
- (void) updateEntry:(ETLEntry *)entry withTitle:(NSString *)title andBodyText:(NSString *)bodyText;

@end
