//
//  ETLPokemon.m
//  PokedexC
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLPokemon.h"

@implementation ETLPokemon

-(instancetype) initWithName:(NSString *)name number:(NSInteger)number abilities:(NSArray<NSString *> *)abilities
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _number = number;
        _abilities = [abilities copy];
    }
    return self;
}

-(instancetype)init
{
    return [self initWithName: @"" number:0 abilities:@[]];
}

@end

@implementation ETLPokemon (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSInteger number = [dictionary[@"id"] integerValue];
    NSArray *abilitiesDictionaryArray = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [NSMutableArray new];
    
    for (NSDictionary *abilitDictionary in abilitiesDictionaryArray) {
        NSDictionary *nestedDictionary = abilitDictionary[@"ability"];
        NSString *abilityName = nestedDictionary[@"name"];
        
        [abilities addObject:abilityName];
    }
    
    return [self initWithName:name number:number abilities:abilities];
}

@end

