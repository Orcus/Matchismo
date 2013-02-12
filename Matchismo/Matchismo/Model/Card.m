//
//  Card.m
//  Matchismo
//
//  Created by Kevin on 1/28/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
            break;
        }
    }
    
    return score;
}

- (NSString *)description
{
    return self.contents;
}

- (id)copyWithZone:(NSZone *)zone
{
    Card *copy = [[[self class] alloc] init];

    if (copy) {
        copy.contents   = [self.contents copyWithZone:zone];
        copy.faceUp     = self.isFaceUp;
        copy.unplayable = self.isUnplayable;
    }

    return copy;
}

@end
