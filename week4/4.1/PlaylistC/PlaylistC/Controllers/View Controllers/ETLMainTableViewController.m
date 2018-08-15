//
//  ETLMainTableViewController.m
//  PlaylistC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLMainTableViewController.h"
#import "ETLPlaylistController.h"
#import "ETLDetailTableViewController.h"

@interface ETLMainTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation ETLMainTableViewController

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    [[ETLPlaylistController sharedController] createPlaylistWithName: self.nameTextField.text];
    [self.tableView reloadData];
    self.nameTextField.text = @"";
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ETLPlaylistController sharedController] playlists] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playlistCell" forIndexPath:indexPath];
    
    ETLPlaylist *playlist = [[[ETLPlaylistController sharedController] playlists] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [playlist name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu songs", playlist.songs.count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ETLPlaylist *playlist = [[ETLPlaylistController sharedController] playlists][indexPath.row];
        
        [[ETLPlaylistController sharedController] deletePlaylist:playlist];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([[segue identifier]  isEqualToString: @"toDetailVC"])
     {
         NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
         ETLPlaylist *selectedPlaylist = [[ETLPlaylistController sharedController] playlists][selectedIndexPath.row];
         ETLDetailTableViewController *destinationVC = [segue destinationViewController];
         destinationVC.playlist = selectedPlaylist;
     }
 }


@end
