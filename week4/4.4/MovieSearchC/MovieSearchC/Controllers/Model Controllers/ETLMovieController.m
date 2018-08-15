//
//  ETLMovieController.m
//  MovieSearchC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLMovieController.h"
#import "ETLMovie.h"

static NSString * const baseURL = @"https://api.themoviedb.org/3/search/movie";
static NSString * const apiKey = @"6f4d981b8c65512f465ce5bc85513205";
static NSString * const baseImageURL = @"http://image.tmdb.org/t/p/w500";


@implementation ETLMovieController

#pragma Mark - Shared Instance
+ (instancetype)sharedController
{
    static ETLMovieController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [ETLMovieController new];
    });
    return sharedController;
}

#pragma Mark - GET Request Methods
- (void)fetchMoviesForSearchTerm:(NSString *)searchTerm completion:(void (^)(BOOL))completion
{
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    NSURLQueryItem *searchQuery = [NSURLQueryItem queryItemWithName:@"query" value:searchTerm];
    NSURLComponents *components = [NSURLComponents componentsWithString:baseURL];
    components.queryItems = @[apiQuery, searchQuery];
    NSURL *url = [components URL];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching data from URL; %@", error);
            completion(false); return;
        }
        
        if (!data) {
            NSLog(@"Error with data from URL");
            completion(false); return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray<NSDictionary *> *secondLevelJSON = topLevelJSON[@"results"];
        NSMutableArray *moviesArray = [NSMutableArray new];
        
        for (NSDictionary *dictionary in secondLevelJSON) {
            ETLMovie *movie = [[ETLMovie alloc] initWithDictionary:dictionary];
            [moviesArray addObject:movie];
        }
        
        ETLMovieController.sharedController.movies = moviesArray;
        completion(true);
    }] resume];
}

- (void)fetchMoviePosterForMovie:(ETLMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:baseImageURL];
    NSURL *fullURL = [url URLByAppendingPathComponent:movie.posterPath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:fullURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching image data from URL; %@", error);
            completion(nil); return;
        }
        
        if (!data) {
            NSLog(@"Error with image data from URL");
            completion(nil); return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        
        completion(image);
    }] resume];
}
@end
