//
//  Representative.h
//  ObjCRep
//
//  Created by Eric Lanza on 8/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Representative : NSObject

@property (nonatomic, readonly, copy) NSString *name;
-(instancetype) initWithName:(NSString *)name;


@end
