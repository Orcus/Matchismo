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
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMatchMode;
@property (weak, nonatomic) IBOutlet UISlider *gameMatchHistory;
@property (strong, nonatomic) CardMatchingGame *game;
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
- (IBAction)dealCards:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    [self.gameMatchMode setEnabled:YES];
    [self updateUI];
}

- (IBAction)selectGameMode:(UISegmentedControl *)sender
{
    [self setGameMode:sender.selectedSegmentIndex + 2];
}

- (void)setGameMode:(NSUInteger)mode
{
    UIImage *backImage;
    self.game.cardsToMatch = mode;

    switch (mode) {
        case 2:
            backImage = [UIImage imageNamed:@"back-red-75-2.png"];
            break;
        case 3:
            backImage = [UIImage imageNamed:@"back-blue-75-2.png"];
            break;
        default:
            backImage = [[UIImage alloc] init];
            break;
    }

    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setImage:backImage
                    forState:UIControlStateNormal];
    }
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self.gameMatchMode setEnabled:NO];
    [self updateUI];
}

- (void)viewDidLoad
{
    UIImage *emptyImage = [[UIImage alloc] init];    

    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [cardButton setImage:emptyImage
                    forState:UIControlStateSelected];
        [cardButton setImage:emptyImage
                    forState:UIControlStateSelected | UIControlStateDisabled];
    }

    [self setGameMode:self.gameMatchMode.selectedSegmentIndex + 2];
}

@end
