//
//  RepresentativeController.h
//  ObjCRep
//
//  Created by Eric Lanza on 8/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Representative;

@interface RepresentativeController : NSObject

@property (nonatomic) NSURL *baseURL;
@property (nonatomic) NSMutableArray *repArray;
- (void) searchRepresentativeForState:(NSString *)state completion:(void (^) (NSMutableArray<Representative*> *reps))completion;

@end
