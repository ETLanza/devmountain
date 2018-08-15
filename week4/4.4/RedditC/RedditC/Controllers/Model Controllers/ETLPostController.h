//
//  ETLPostController.h
//  RedditC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETLPost;
NS_ASSUME_NONNULL_BEGIN
@interface ETLPostController : NSObject

@property (nonatomic, copy) NSArray<ETLPost *> *posts;

+(instancetype) sharedController;

-(void)fetchPosts:(void (^)(BOOL))completion;

-(void)fetchImageForPost:(ETLPost *)post completion:(void (^) (UIImage * _Nullable))completion;
NS_ASSUME_NONNULL_END
@end
