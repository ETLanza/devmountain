//
//  ETLPlaylistController.h
//  PlaylistC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETLPlaylist.h"
#import "ETLSong.h"


@class ETLSong;
@class ETLPlaylist;

@interface ETLPlaylistController : NSObject

@property (nonatomic, strong, readonly) NSArray *playlists;

+ (ETLPlaylistController *) sharedController;

- (void) createPlaylistWithName:(NSString *)name;
- (void) addSongWithTitle:(NSString *)title andArtist:(NSString *)artist toPlaylist:(ETLPlaylist *)playlist;
- (void) deletePlaylist:(ETLPlaylist *)playlist;
- (void) deleteSong:(ETLSong *)song fromPlaylist:(ETLPlaylist *)playlist;

@end
