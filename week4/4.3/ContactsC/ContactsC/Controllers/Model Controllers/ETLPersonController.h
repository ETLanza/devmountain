//
//  ETLPersonController.h
//  ContactsC
//
//  Created by Eric Lanza on 7/25/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETLPerson;

@interface ETLPersonController : NSObject

+(instancetype) sharedController;

@property (nonatomic, retain, readonly) NSArray *people;

-(void)addPerson:(ETLPerson *)person;

-(void)deletePerson:(ETLPerson *)person;



@end
