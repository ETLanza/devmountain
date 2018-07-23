//
//  DMNPerson.h
//  ObjC
//
//  Created by Eric Lanza on 7/21/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMNPerson : NSObject

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age height:(float)height;

- (void)sayYourName;
+ (float)averageHeight;
- (void)eatFoot:(NSString *)food;
- (void)driveCar:(NSString *)car to:(NSString *)location bringingAlong:(DMNPerson *)person;

@property NSString *name;
@property NSInteger age;
@property float height;

@end
