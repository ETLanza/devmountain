//
//  ETLPostController.m
//  RedditC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLPostController.h"
#import "ETLPost.h"

static NSString * const baseURLString = @"http://www.reddit.com/.json";

@implementation ETLPostController

+ (instancetype)sharedController
{
    static ETLPostController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [ETLPostController new];
    });
    return sharedController;
}

- (void)fetchPosts:(void (^)(BOOL))completion
{
    NSURL *url = [NSURL URLWithString:baseURLString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching Post: %@", error);
            completion(false); return;
        }
        
        if (!data) {
            NSLog(@"Error with fetched post data");
            completion(false); return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *secondLevelJson = topLevelJSON[@"data"];
        NSArray<NSDictionary *> *thirdLevelJson = secondLevelJson[@"children"];
        
        NSMutableArray *arrayOfPost = [NSMutableArray new];
        
        for (NSDictionary* currentDictionary in thirdLevelJson) {
            NSDictionary *postDictionary = currentDictionary[@"data"];
            ETLPost *post = [[ETLPost alloc] initWithDictionary:postDictionary];
            [arrayOfPost addObject:post];
        }
        
        ETLPostController.sharedController.posts = arrayOfPost;
        completion(true);
        
    }] resume];
    
}

- (void)fetchImageForPost:(ETLPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    if (post.thumbnail.length < 10 ){
        completion(nil); return;
    }
    NSURL *url = [NSURL URLWithString: post.thumbnail];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching Post Image: %@", error);
            completion(nil); return;
        }
        
        if (!data) {
            NSLog(@"Error with fetched post image data");
            completion(nil); return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }] resume];
}
@end
