//
//  MatchState.m
//  Matchismo
//
//  Created by Kevin Tong on 2/1/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "MatchStatus.h"

@interface MatchStatus()

// the array of objects to match
@property (strong, nonatomic) NSMutableArray *matchGroup;
@end

@implementation MatchStatus

- (NSMutableArray *)matchGroup
{
    if (!_matchGroup) {
        _matchGroup = [[NSMutableArray alloc] init];
    }

    return _matchGroup;
}

- (id)copyWithZone:(NSZone *)zone
{
    MatchStatus *copy = [[MatchStatus alloc] init];

    if (copy) {
        copy.matchGroup = [self.matchGroup copyWithZone:zone];
        copy.match = self.isMatch;
        copy.flip = self.isFlip;
        copy.score = self.score;
    }

    return copy;
}

- (void)addObject:(id)anObject
{
    if (anObject) {
        [self.matchGroup addObject:anObject];
    }
}

- (NSArray *)group
{
    return [NSArray arrayWithArray:self.matchGroup];
    //return [[NSArray alloc] initWithArray:self.matchGroup];
}

@end
