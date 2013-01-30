//
//  PlayingCard.m
//  Matchismo
//
//  Created by Kevin on 1/28/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray  *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

// HAVE to synthesize because setter AND getter was implemented
@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;

    if (!validSuits) {
        validSuits = @[@"♥", @"♦", @"♠", @"♣"];
    }

    return validSuits;
}

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

@end
