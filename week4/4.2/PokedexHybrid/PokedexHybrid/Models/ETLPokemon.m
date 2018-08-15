//
//  ETLPokemon.m
//  PokedexHybrid
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLPokemon.h"
@implementation ETLPokemon
- (instancetype)initWithName:(NSString *)name identifier:(NSInteger)identifier ability:(NSArray<NSString *> *)abilities
{
    // All Obj-C init are failable
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = identifier;
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithName:@"" identifier:0 ability:@[]];
}

@end

@implementation ETLPokemon (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSInteger identifier = [dictionary[@"id"] integerValue];
    NSArray *abilitiesDictionaryArray = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [NSMutableArray new];
    
    for (NSDictionary *abilityDictionary in abilitiesDictionaryArray) {
        
        NSDictionary *nestedDictionary = abilityDictionary[@"ability"];
        NSString *abilityName = nestedDictionary[@"name"];
        
        [abilities addObject:abilityName];
    }
    
    return [self initWithName:name identifier:identifier ability:abilities];
}
@end
