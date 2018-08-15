//
//  ETLPokemonController.h
//  PokedexHybrid
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class ETLPokemon;

@interface ETLPokemonController : NSObject

- (void)fetchPokemoneWithSearchTerm:(NSString *)serchTerm completion:(void (^) (ETLPokemon *))completion;

+ (ETLPokemonController *)sharedController;

@end
NS_ASSUME_NONNULL_END
