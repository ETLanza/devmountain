//
//  ETLMovie.m
//  MovieSearchC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLMovie.h"

@implementation ETLMovie
NS_ASSUME_NONNULL_BEGIN
- (instancetype)initWithTitle:(NSString *)title rating:(NSInteger)rating overview:(NSString *)overview posterPath:(NSString * _Nullable)posterPath
{
    self = [super init];
    if (self){
        _title = [title copy];
        _rating = rating;
        _overview = [overview copy];
        _posterPath = [posterPath copy];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:@"" rating:0 overview:@"" posterPath:@""];
}
@end

@implementation ETLMovie (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSNumber *rating = dictionary[@"vote_average"];
    NSString *overview = dictionary[@"overview"];
    NSString *posterPath = dictionary[@"poster_path"];
    
    if ([posterPath isMemberOfClass: [NSNull class]]) {
        posterPath = nil;
    }
    
    return [self initWithTitle:title rating:[rating integerValue] overview:overview posterPath:posterPath];
}
NS_ASSUME_NONNULL_END
@end

