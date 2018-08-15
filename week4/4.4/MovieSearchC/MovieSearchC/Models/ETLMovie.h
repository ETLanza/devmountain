//
//  ETLMovie.h
//  MovieSearchC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETLMovie : NSObject
NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, copy) NSString *title;
@property (nonatomic) NSInteger rating;
@property (nonatomic, copy) NSString *overview;
@property (nonatomic, copy, nullable) NSString *posterPath;

-(instancetype) initWithTitle:(NSString *)title rating:(NSInteger)rating overview:(NSString *)overview posterPath:(NSString *_Nullable)posterPath NS_DESIGNATED_INITIALIZER;

NS_ASSUME_NONNULL_END
@end

@interface ETLMovie (JSONConvertable)

-(instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
