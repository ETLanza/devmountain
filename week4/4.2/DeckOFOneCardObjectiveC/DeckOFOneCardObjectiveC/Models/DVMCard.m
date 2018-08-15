//
//  DVMCard.m
//  DeckOFOneCardObjectiveC
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

- (instancetype)initWithSuit:(NSString *)suit imageURLAsString:(NSString *)imageURL
{
    self = [super init];
    if (self) {
        _suit = [suit copy];
        _imageURLAsString = [imageURL copy];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithSuit:@"" imageURLAsString:@""];
}

@end

@implementation DVMCard (JSONConvertable)

+(NSString *)suitKey
  {
      return @"suit";
  }

+(NSString *)imageKey
{
    return @"image";
}
  
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *suit = dictionary[[DVMCard suitKey]];
    NSString *imageURLAsString = dictionary[[DVMCard imageKey]];
    
    return [self initWithSuit:suit imageURLAsString:imageURLAsString];
}

@end

