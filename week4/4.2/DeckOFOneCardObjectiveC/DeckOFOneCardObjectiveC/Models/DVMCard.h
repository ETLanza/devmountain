//
//  DVMCard.h
//  DeckOFOneCardObjectiveC
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVMCard : NSObject

@property (nonatomic, copy, readonly) NSString *suit;
@property (nonatomic, copy, readonly) NSString *imageURLAsString;

-(instancetype)initWithSuit:(NSString *)suit imageURLAsString:(NSString *)imageURL NS_DESIGNATED_INITIALIZER;


@end

@interface DVMCard (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
