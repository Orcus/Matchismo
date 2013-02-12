//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kevin Tong on 1/30/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) int score;

// The code to generate a match status string should be in the controller and
// corresponds to a match status in the model. The model has a list of past
// match status. The controller interprets the data from the model for the view.
@property (strong, nonatomic) NSMutableArray *matchHistory; // of MatchStatus
@end

@implementation CardMatchingGame

// count can be different from this method's signature in the header file
- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];

    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];

            if (!card) {
                self = nil;
                break;
            } else {
                self.cards[i] = card;
            }
        }
    }

    if (self) {
        //set up default values for scoring
        self.flipCost = 1;
        self.mismatchPenalty = 2;
        self.matchBonus = 4;
    }

    return self;
}

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (NSMutableArray *)matchHistory
{
    if (!_matchHistory) {
        _matchHistory = [[NSMutableArray alloc] init];
    }

    return _matchHistory;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];

    if (card && !card.isUnplayable) {

        MatchStatus *status = [[MatchStatus alloc]init];
        [status addObject:[card copy]];

        if (!card.isFaceUp) {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            status.flip = YES;
            status.score -= self.flipCost;

            // find other playable face up cards to match against
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                }

                // stop when enough cards to match against are found as
                // there shouldn't be more cards than necessary
                if ([otherCards count] == self.cardsToMatch - 1) {
                    break;
                }
            }

            // don't match unless there are enough cards to match against
            if ([otherCards count] == self.cardsToMatch - 1) {
                int matchScore = [card match:otherCards];
                
                if (matchScore) {
                    for (Card *otherCard in otherCards) {
                        [status addObject:[otherCard copy]];
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    status.match = YES;
                    status.score += matchScore * self.matchBonus * (self.cardsToMatch - 1);
                } else {
                    for (Card *otherCard in otherCards) {
                        [status addObject:[otherCard copy]];
                        otherCard.faceUp = NO;
                    }
                    status.score -= self.mismatchPenalty * (self.cardsToMatch - 1);
                }
            }
            self.score += status.score;
        }
        
        [self.matchHistory addObject:status];
        card.faceUp = !card.faceUp;
    }
}

-(MatchStatus *)matchAtIndex:(NSUInteger)index
{
    if (index < [self.matchHistory count]) {
        return [self.matchHistory[index] copy];
    } else {
        return nil;
    }
}

-(MatchStatus *)recentMatch
{
    return [[self.matchHistory lastObject] copy];
}

@end
