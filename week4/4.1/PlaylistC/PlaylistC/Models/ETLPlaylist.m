//
//  ETLPlaylist.m
//  PlaylistC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLPlaylist.h"

@interface ETLPlaylist()

@property (nonatomic, strong)NSMutableArray* internalSongs;


@end

@implementation ETLPlaylist

- (instancetype)initWithName:(NSString *)name songs:(NSArray *)songs
{
    self = [super init];
    if (self) {
        _name = name;
        _internalSongs = [songs mutableCopy];
    }
    return self;
}

#pragma mark - Methods
- (void)addSongsObject:(ETLSong *)song
{
    [self.internalSongs addObject:song];
}

- (void)removeSongsObject:(ETLSong *)song
{
    [self.internalSongs removeObject:song];
}

- (NSArray *) songs { return self.internalSongs; }

@end
