//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kevin on 1/28/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
//@property (strong, nonatomic) UIImage *emptyImage;
//@property (strong, nonatomic) UIImage *cardBackImage;
@end

@implementation CardGameViewController

#pragma mark - Accessors

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}
/*
- (UIImage *)emptyImage
{
    if (!_emptyImage) {
        _emptyImage = [[UIImage alloc] init];
    }
    return _emptyImage;
}

- (UIImage *)cardBackImage
{
    if (!_cardBackImage) {
        _cardBackImage = [UIImage imageNamed:@"back-red-75-2.png"];
    }
    return _cardBackImage;
}
*/
#pragma mark - Setters

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

#pragma mark - Actions

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected | UIControlStateDisabled];

        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"%d Points", self.game.score];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)viewDidLoad
{
    UIImage *emptyImage = [[UIImage alloc] init];
    UIImage *cardBackImage = [UIImage imageNamed:@"back-red-75-2.png"];
    

    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setImage:emptyImage
                    forState:UIControlStateSelected];
        [cardButton setImage:emptyImage
                    forState:UIControlStateSelected | UIControlStateDisabled];
        [cardButton setImage:cardBackImage
                    forState:UIControlStateNormal];
    }
}



@end
