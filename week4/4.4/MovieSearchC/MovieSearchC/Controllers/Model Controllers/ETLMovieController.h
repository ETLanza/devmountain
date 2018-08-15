//
//  ETLMovieController.h
//  MovieSearchC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ETLMovie;
NS_ASSUME_NONNULL_BEGIN
@interface ETLMovieController : NSObject

@property (nonatomic, copy) NSArray<ETLMovie *> *movies;

+(instancetype) sharedController;

-(void)fetchMoviesForSearchTerm:(NSString *)searchTerm completion:(void (^)(BOOL))completion;

-(void)fetchMoviePosterForMovie:(ETLMovie *)movie completion:(void (^) (UIImage * _Nullable))completion;
NS_ASSUME_NONNULL_END
@end
