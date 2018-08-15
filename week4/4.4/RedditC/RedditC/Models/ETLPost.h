//
//  ETLPost.h
//  RedditC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETLPost : NSObject

@property (nonatomic, copy, nonnull) NSString *title;
@property (nonatomic, copy, nullable) NSString *thumbnail;

-(instancetype) initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail NS_DESIGNATED_INITIALIZER;

@end

@interface ETLPost (JOSNConvertable)

-(instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end



