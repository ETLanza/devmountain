//
//  ETLPlaylistController.m
//  PlaylistC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLPlaylistController.h"


@interface ETLPlaylistController()

@property (nonatomic, strong, readwrite) NSMutableArray *internalPlaylists;

@end

@implementation ETLPlaylistController

#pragma mark - Properties

-(NSArray *)playlists { return self.internalPlaylists; }


+ (ETLPlaylistController *)sharedController
{
    static ETLPlaylistController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [ETLPlaylistController new];
    });
    return sharedController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalPlaylists =[[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addSongWithTitle:(NSString *)title andArtist:(NSString *)artist toPlaylist:(ETLPlaylist *)playlist
{
    ETLSong *mySong = [[ETLSong alloc] initWithTitle:title artist:artist];
    [playlist addSongsObject:mySong];
}

- (void)createPlaylistWithName:(NSString *)name
{
    ETLPlaylist *newPlaylist = [[ETLPlaylist alloc] initWithName:name songs:[[NSMutableArray alloc] init]];
    [self.internalPlaylists addObject:newPlaylist];
}

- (void)deleteSong:(ETLSong *)song fromPlaylist:(ETLPlaylist *)playlist
{
    [playlist removeSongsObject:song];
}

- (void)deletePlaylist:(ETLPlaylist *)playlist
{
    [self.internalPlaylists removeObject:playlist];
}

@end
