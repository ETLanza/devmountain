//
//  ETLEntryDetailViewController.m
//  Journal_ObjC
//
//  Created by Eric Lanza on 7/23/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ETLEntryDetailViewController.h"
#import "ETLEntryController.h"

@interface ETLEntryDetailViewController()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation ETLEntryDetailViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [_bodyTextView becomeFirstResponder];
    return YES;
}

- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    if ([_bodyTextView.text isEqualToString:@""]) { return; }
    if ([_titleTextField.text isEqualToString:@""]) { return; }
    
    if (!_entry)
    {
    ETLEntry *entry = [[ETLEntry alloc] initWithTitle:_titleTextField.text bodyText:_bodyTextView.text];
    [ETLEntryController.sharedController addEntry:entry];
    }
    if (_entry)
    {
        [[ETLEntryController sharedController] updateEntry:_entry withTitle:_titleTextField.text andBodyText:_bodyTextView.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clearTextButtonTapped:(UIButton *)sender {
    _titleTextField.text = @"";
    _bodyTextView.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_entry)
    {
        [self updateWith:_entry];
    }
}

-(void) updateWith:(ETLEntry *)entry
{
        _titleTextField.text = [_entry title];
        _bodyTextView.text = [_entry bodyText];
        self.title = @"Edit Entry";
}

@end
