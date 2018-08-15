//
//  ETLPokemonController.m
//  PokedexHybrid
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLPokemonController.h"
#import "ETLPokemon.h"
#import "PokedexHybrid-Swift.h"


static NSString * const baseURLString = @"https://pokeapi.co/api/v2/pokemon";

@implementation ETLPokemonController

+ (ETLPokemonController *)sharedController
{
    static ETLPokemonController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [ETLPokemonController new];
    });
    return sharedController;
}

- (void)fetchPokemoneWithSearchTerm:(NSString *)searchTerm completion:(void (^)(ETLPokemon *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent:searchTerm];
    
    [NetworkController performRequestFor:searchURL httpMethod:@"GET" urlParameters:nil body:nil completion:^(NSData * data, NSError * error) {
        
        if (error) {
            NSLog(@"Error fetching pokemon from search term: %@", error);
            completion(nil); return;
        }
        
        if (!data) {
            NSLog(@"Error fetching pokemon data");
            completion(nil); return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error with JSON Serilization");
            completion(nil); return;
        }
        
        ETLPokemon *pokemon = [[ETLPokemon alloc] initWithDictionary:jsonDictionary];
        completion(pokemon);
        
    }];
}

@end
