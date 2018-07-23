//
//  Planet.h
//  Solar System
//
//  Created by Eric Lanza on 7/21/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Planet : NSObject

- (instancetype)initWithName:(NSString *)name
                    diameter:(NSInteger)diameter
                   dayLength:(float)dayLength
           millionKMsFromSun:(float)millionKMsFromSun;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *imageName;
@property (nonatomic, readonly) NSInteger diameter;
@property (nonatomic, readonly) float dayLength;
@property (nonatomic, readonly) float   millionKMsFromSun;

@end
