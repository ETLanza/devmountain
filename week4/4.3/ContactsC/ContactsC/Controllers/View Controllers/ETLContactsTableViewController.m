//
//  ETLContactsTableViewController.m
//  ContactsC
//
//  Created by Eric Lanza on 7/25/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLContactsTableViewController.h"
#import "ETLPerson.h"
#import "ETLPersonController.h"

@interface ETLContactsTableViewController ()


@end

@implementation ETLContactsTableViewController

- (IBAction)createNewContact:(UIBarButtonItem *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Create Contact" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter name";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter phone number";
    }];
    
    UIAlertAction *createAction = [UIAlertAction actionWithTitle:@"Create" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ETLPerson *person = [[ETLPerson alloc] initWithName:alertController.textFields.firstObject.text
                                                phoneNumber:alertController.textFields.lastObject.text];
        [[ETLPersonController sharedController] addPerson:person];
        
        [person release];
        [[self tableView] reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:createAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ETLPersonController sharedController] people] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell" forIndexPath:indexPath];
    
    ETLPerson *person = [[[ETLPersonController sharedController] people] objectAtIndex:indexPath.row];
    cell.textLabel.text = [person name];
    cell.detailTextLabel.text = [person phoneNumber];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ETLPerson *person = [[[ETLPersonController sharedController] people] objectAtIndex:indexPath.row];
        [[ETLPersonController sharedController] deletePerson:person];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
