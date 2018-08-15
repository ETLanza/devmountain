//
//  RepresentativeController.m
//  ObjCRep
//
//  Created by Eric Lanza on 8/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

#import "RepresentativeController.h"
#import "Representative.h"

@implementation RepresentativeController
{
    NSURL *_baseURL;
    NSMutableArray<Representative*> *_repArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseURL = [[NSURL alloc] initWithString:@"https://whoismyrepresentative.com/getall_reps_bystate.php"];
        _repArray = [NSMutableArray new];
    }
    return self;
}

- (void) searchRepresentativeForState:(NSString *)state completion:(void (^) (NSMutableArray<Representative*> *reps))completion
{
    NSURLQueryItem *stateQuery = [NSURLQueryItem queryItemWithName:@"state" value:state];\
    NSURLQueryItem *outputItem = [NSURLQueryItem queryItemWithName:@"output" value:@"json"];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:_baseURL resolvingAgainstBaseURL:true];
    components.queryItems = @[stateQuery, outputItem];
    
    NSURL *requestURL = [components URL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fecthing data from URL: %@", error);
            return;
        }
        
        if (!data) {
            NSLog(@"Error reading data");
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSArray *jsonArray = topLevelJSON[@"results"];
        
        for (NSDictionary *dictionary in jsonArray) {
            Representative *newRep = [[Representative alloc] initWithName:dictionary[@"name"]];
            [self->_repArray addObject:newRep];
        }
        
        completion(self->_repArray);
        
    }] resume];
}

@end
