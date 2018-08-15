//
//  ETLDetailTableViewController.h
//  PlaylistC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETLPlaylist;

@interface ETLDetailTableViewController : UITableViewController

@property (nonatomic, strong) ETLPlaylist *playlist;

@end
