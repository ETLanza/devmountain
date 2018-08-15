//
//  DVMCardController.m
//  DeckOFOneCardObjectiveC
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "DVMCardController.h"

static NSString * const baseURL = @"https://deckofcardsapi.com/api/deck/new/draw";

@implementation DVMCardController

+ (DVMCardController *)sharedController
{
    static DVMCardController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [DVMCardController new];
    });
    return sharedController;
}


- (void)drawANewCard:(NSInteger)count completion:(void (^)(NSArray<DVMCard *> * _Nullable, NSError * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:baseURL];
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *countQueryItem = [NSURLQueryItem queryItemWithName:@"count" value:@"1"];
    components.queryItems = @[countQueryItem];
    NSURL *requestURL = [components URL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching data from URL: %@", error);
            completion(nil, error); return ;
        }
        
        if (!data) {
            NSLog(@"Error reading data");
            completion(nil, error); return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSArray *cardsArray = jsonDictionary[@"cards"];
        NSMutableArray *cardsPlaceholder = [NSMutableArray new];
        
        for (NSDictionary *dictionary in cardsArray) {
            DVMCard *card = [[DVMCard alloc] initWithDictionary:dictionary];
            [cardsPlaceholder addObject:card];
        }
        
        
        completion(cardsPlaceholder, nil);
        
        
    }] resume];
}

- (void)fetchCardImageForCard:(DVMCard *)card completion:(void (^)(UIImage *))completion
{
    NSURL *imageURL = [NSURL URLWithString:[card imageURLAsString]];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image from URL: %@", error);
            completion(nil); return;
        }
        
        if (!data) {
            NSLog(@"Error getting image data from URL");
            completion(nil); return;
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage);
        
    }] resume];
}

@end
