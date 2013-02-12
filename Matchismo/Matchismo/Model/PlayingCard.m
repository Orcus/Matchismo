//
//  PlayingCard.m
//  Matchismo
//
//  Created by Kevin on 1/28/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// match returns:
// 0 if all cards don't match
// 1 if all cards match suit
// 4 if all cards match rank
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    BOOL isSuitMatch = YES; // once this is set to NO, it should remain NO
    BOOL isRankMatch = YES; // once this is set to NO, it should remain NO

    if ([otherCards count] > 0) {
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherPlayingCard = otherCard;
                if (![otherPlayingCard.suit isEqualToString:self.suit]) {
                    isSuitMatch = NO;
                }

                if (otherPlayingCard.rank != self.rank) {
                    isRankMatch = NO;
                }

                // stop matching when a complete mismatch is found
                if (!isSuitMatch && !isRankMatch) {
                    break;
                }
            } else {
                // not a PlayingCard so not a match at all
                isSuitMatch = isRankMatch = NO;
                break;
            }
        }
    }

    if (isSuitMatch) {
        score = 1;
    } else if (isRankMatch) {
        score = 4;
    }

    return score;
}


- (NSString *)contents
{
    NSArray  *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;

    if (!validSuits) {
        validSuits = @[@"♥", @"♦", @"♠", @"♣"];
    }

    return validSuits;
}

// HAVE to synthesize because setter AND getter was implemented
@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    static NSArray *rankStrings = nil;

    if (!rankStrings) {
        rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    }

    return rankStrings;
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

- (id)copyWithZone:(NSZone *)zone
{
    PlayingCard *copy = [super copyWithZone:zone];

    if (copy) {
        copy.suit = [self.suit copyWithZone:zone];
        copy.rank = self.rank;
    }

    return copy;
}

@end
