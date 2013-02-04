//
//  MatchState.h
//  Matchismo
//
//  Created by Kevin Tong on 2/1/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchStatus : NSObject <NSCopying>

// YES when the array of objects match
@property (nonatomic, getter = isMatch) BOOL match;
@property (nonatomic, getter = isFlip) BOOL flip;
@property (nonatomic) int score;

- (void)addObject:(id)anObject;
- (NSArray *)group;
@end
