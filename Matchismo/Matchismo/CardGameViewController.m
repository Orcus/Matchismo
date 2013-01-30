//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kevin on 1/28/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;
@end

@implementation CardGameViewController

#pragma mark - Accessors

- (PlayingCardDeck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    
    return _deck;
}

#pragma mark - Setters

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

#pragma mark - Actions

- (IBAction)flipCard:(UIButton *)sender
{
    // TODO: flip through cards in a deck

    sender.selected = !sender.isSelected;

    if (sender.selected) {
        Card *card = [self.deck drawRandomCard];

        if (card) {
            [sender setTitle:card.contents forState:UIControlStateSelected];
        } else {
            [sender setTitle:@"∅" forState:UIControlStateSelected];

        }

        if (self.deck.countCard) {
            self.statusLabel.text = [NSString stringWithFormat:@"Status: %d cards in deck", self.deck.countCard];
        } else {
            self.statusLabel.text = @"Status: empty deck";
        }
    }

    self.flipCount++;
}

@end
