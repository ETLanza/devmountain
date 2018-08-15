//
//  ETLDetailTableViewController.m
//  PlaylistC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLDetailTableViewController.h"
#import "ETLPlaylist.h"
#import "ETLSong.h"

@interface ETLDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *artistNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *songTitleTextField;

@end

@implementation ETLDetailTableViewController

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    ETLSong *newSong = [[ETLSong alloc] initWithTitle:self.songTitleTextField.text artist: self.artistNameTextField.text];
    [self.playlist addSongsObject:newSong];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [self.playlist name];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playlist.songs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell" forIndexPath:indexPath];
    
    ETLSong *song = [self.playlist.songs objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [song title];
    cell.detailTextLabel.text = [song artist];
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ETLSong *song = self.playlist.songs[indexPath.row];
        [self.playlist removeSongsObject:song];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
