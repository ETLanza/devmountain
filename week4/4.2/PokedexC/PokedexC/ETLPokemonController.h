//
//  ETLPokemonController.h
//  PokedexC
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ETLPokemon;

@interface ETLPokemonController : NSObject

+ (void)fetchPokemonWithSearchTerm:(NSString *)searchTerm
                        completion:(void (^) (ETLPokemon * _Nullable))completion;

@end
NS_ASSUME_NONNULL_END
