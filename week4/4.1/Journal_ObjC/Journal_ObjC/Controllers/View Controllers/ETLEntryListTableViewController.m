//
//  ETLEntryListTableViewController.m
//  Journal_ObjC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLEntryListTableViewController.h"
#import "ETLEntryController.h"
#import "ETLEntryDetailViewController.h"

@interface ETLEntryListTableViewController ()

@end

@implementation ETLEntryListTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ETLEntryController.sharedController.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entryCell" forIndexPath:indexPath];
    
    ETLEntry *entry = [[[ETLEntryController sharedController] entries] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [entry title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ETLEntry *entry = [[[ETLEntryController sharedController] entries] objectAtIndex:indexPath.row];
        [[ETLEntryController sharedController] removeEntry:entry];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"editEntrySegue"])
    {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        ETLEntry *selectEntry = [[ETLEntryController sharedController] entries][selectedIndexPath.row];
        ETLEntryDetailViewController *destinationVC = [segue destinationViewController];
        destinationVC.entry = selectEntry;
    }
}

@end
