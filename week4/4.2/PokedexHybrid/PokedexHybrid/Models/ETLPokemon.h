//
//  ETLPokemon.h
//  PokedexHybrid
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface ETLPokemon : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, copy, readonly) NSArray<NSString *> *abilities;

- (instancetype) initWithName:(NSString *)name identifier:(NSInteger)identifier ability:(NSArray<NSString *> *)abilities NS_DESIGNATED_INITIALIZER;

@end

@interface ETLPokemon (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary <NSString *, id>* )dictionary;

@end
NS_ASSUME_NONNULL_END
