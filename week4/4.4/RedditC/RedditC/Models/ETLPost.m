//
//  ETLPost.m
//  RedditC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLPost.h"

@implementation ETLPost

- (instancetype)initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail
{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _thumbnail = [thumbnail copy];
    }
    return self;
}
- (instancetype)init
{
    return [self initWithTitle:@"" thumbnail:@""];
}

@end


@implementation ETLPost (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSString *thumbnail = dictionary[@"thumbnail"];

    return [self initWithTitle:title thumbnail:thumbnail];
}
@end

