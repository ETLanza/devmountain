//
//  DVMCardController.h
//  DeckOFOneCardObjectiveC
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVMCard.h"


@interface DVMCardController : NSObject

+(DVMCardController *) sharedController;

-(void)drawANewCard:(NSInteger)count completion:(void(^) (NSArray<DVMCard *> *cards, NSError *error))completion;


-(void)fetchCardImageForCard:(DVMCard *)card completion:(void(^) (UIImage *))completion;

@end
