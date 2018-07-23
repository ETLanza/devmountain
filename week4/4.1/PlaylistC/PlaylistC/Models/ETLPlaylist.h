//
//  ETLPlaylist.h
//  PlaylistC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETLSong;

@interface ETLPlaylist : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong, readonly)NSArray* songs;

- (void)addSongsObject:(ETLSong *)object;
- (void)removeSongsObject:(ETLSong *)object;

- (instancetype) initWithName:(NSString *)name songs:(NSArray *)songs;

@end
