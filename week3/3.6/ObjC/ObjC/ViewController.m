//
//  ViewController.m
//  ObjC
//
//  Created by Eric Lanza on 7/21/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "ViewController.h"
#import "DMNPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DMNPerson *person = [[DMNPerson alloc] initWithName:@"Steve" age:62 height:6];
    person.height = 5.5;
    
    [person sayYourName];
    DMNPerson *friend = [[DMNPerson alloc] initWithName:@"Jony" age:50 height:6.2];
    [person driveCar:@"Yellow Corvet" to:@"New York" bringingAlong:friend];
}

@end
