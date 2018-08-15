//
//  RepTableViewController.m
//  ObjCRep
//
//  Created by Eric Lanza on 8/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "RepTableViewController.h"

@interface RepTableViewController ()

@end

@implementation RepTableViewController
{
    NSMutableArray<Representative*> *_repArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _repController = [[RepresentativeController alloc] init];
    _repArray = [NSMutableArray new];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _repArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repCell" forIndexPath:indexPath];
    
    
    return cell;
}

-(void)performNetworkCall:(NSString *)state {
    _repController searchRepresentativeForState:<#(NSString *)#> completion:^(NSMutableArray<Representative *> *reps) {
        <#code#>
    }
}
@end
