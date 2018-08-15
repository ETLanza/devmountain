//
//  ETLPerson.h
//  ContactsC
//
//  Created by Eric Lanza on 7/25/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETLPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;

-(instancetype) initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber;

@end
