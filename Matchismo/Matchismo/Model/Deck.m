//
//  Deck.m
//  Matchismo
//
//  Created by Kevin on 1/28/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil; // unnecessary to set nil
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

- (NSUInteger)countCards
{
    return [self.cards count];
}

- (void)shuffle:(BOOL)byHands
{
    if ([self.cards count] > 1) {
        // TODO: shuffle

        if (byHands) {
            // shuffle "realistically" as if by 2 hands
            // cut the deck in half
            // bottom half randomly interlace into top half
        } else {
            // shuffle randomly
        }
    }
}

- (void)removeAllCards
{
    [self.cards removeAllObjects];
}

@end
