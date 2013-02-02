//
//  MatchState.h
//  Matchismo
//
//  Created by Kevin Tong on 2/1/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchStatus : NSObject

// matchSet[0] is the item to match
// matchSet[1...n] are the other items to match against
@property (strong, nonatomic) NSArray *matchSet;

// if the set matches then match should be YES;
@property (nonatomic, getter = isMatch) BOOL match;
@end
