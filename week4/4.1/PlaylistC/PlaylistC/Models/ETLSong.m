//
//  ETLSong.m
//  PlaylistC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLSong.h"

@implementation ETLSong

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist
{
    self = [super init];
    if (self) {
        _title = title;
        _artist = artist;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    // Are the two classes equal?
    if (![object isKindOfClass:[ETLSong class]]) { return NO; }
    
    //Cast object as ETLSong
    ETLSong *song = object;
    
    // Check for the properties of the class
    if (![song.title isEqual:self.title] && song.title != self.title) { return NO; }
    if (![song.artist isEqual:self.artist] && song.artist != self.artist) { return NO; }
    
    return YES;
}

@end
