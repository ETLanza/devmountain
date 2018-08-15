//
//  Entry.h
//  Journal_ObjC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETLEntry : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* bodyText;
@property (nonatomic, copy) NSDate* timestamp;

- (instancetype)initWithTitle:(NSString *)title bodyText:(NSString *)bodyText;
@end
