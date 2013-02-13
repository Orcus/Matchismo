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
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMatchMode;
@property (weak, nonatomic) IBOutlet UISlider *gameMatchHistory;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int flipCount;
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
    self.flipsLabel.text = [NSString stringWithFormat:@" Flips: %d", self.flipCount];
}

#pragma mark - Actions

- (void)updateUI
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%d Points ", self.game.score];
    [self updateCards];
    [self updateStatus];
}

- (void)updateCards
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected | UIControlStateDisabled];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected | UIControlStateHighlighted];

        if (cardButton.selected != card.isFaceUp) {
            [UIView transitionWithView:cardButton
                              duration:0.5
                               options:cardButton.isSelected ?
                                            UIViewAnimationOptionTransitionFlipFromRight :
                                            UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{}
                            completion:NULL];
        }

        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }    
}

- (IBAction)dealCards:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Start a New Game?"
                          message:@"Current game and score will reset!"
                          delegate:self
                          cancelButtonTitle:@"No"
                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // start a new game
        self.game = nil;
        // have to set card matching mode
        [self updateGameMode:self.gameMatchMode.selectedSegmentIndex + 2];
        self.flipCount = 0;
        [self.gameMatchMode setEnabled:YES];
        [self.gameMatchHistory setEnabled:NO];
        self.gameMatchHistory.minimumValue = 0;
        self.gameMatchHistory.maximumValue = 0;
        [self updateUI];
    }

    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

- (IBAction)selectGameMode:(UISegmentedControl *)sender
{
    [self updateGameMode:sender.selectedSegmentIndex + 2];
}

- (void)updateGameMode:(NSUInteger)mode
{
    UIImage *backImage;
    self.game.cardsToMatch = mode;

    switch (mode) {
        case 2:
            [self.dealButton setTitleColor:[UIColor redColor]
                                  forState:UIControlStateNormal];
            backImage = [UIImage imageNamed:@"back-red-75-2.png"];
            break;
        case 3:
            [self.dealButton setTitleColor:[UIColor blueColor]
                                  forState:UIControlStateNormal];
            backImage = [UIImage imageNamed:@"back-blue-75-2.png"];
            break;
        default:
            backImage = [[UIImage alloc] init];
            break;
    }

    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setImage:backImage
                    forState:UIControlStateNormal];
        [cardButton setImage:backImage
                    forState:UIControlStateNormal | UIControlStateHighlighted];
    }
}

- (IBAction)checkMatchHistory:(UISlider *)sender
{
    [self updateStatus];
}

- (void)updateStatus
{
    if (self.gameMatchHistory.value > 0) {
        MatchStatus *status = [self.game matchAtIndex:self.gameMatchHistory.value - 1];
        self.statusLabel.attributedText = [self historyText:status];
    } else {
        // must be history at index 0, therefore a new game
        self.statusLabel.text = @"New Game";
    }

    if (self.gameMatchHistory.maximumValue > 0 &&
        self.gameMatchHistory.value < self.gameMatchHistory.maximumValue) {
        self.statusLabel.alpha = 0.5;
    } else {
        self.statusLabel.alpha = 1.0;
    }
}

- (NSAttributedString *)historyText:(MatchStatus *)status
{
    NSMutableString *text = [[NSMutableString alloc]
                             initWithString:[[status group] componentsJoinedByString:@","]];
    
    if ([[status group] count] == 1) {
        if (status.isFlip) {
            [text appendFormat:@" flipped up, %d point", status.score];
        } else {
            [text appendString:@" flipped down"];
        }
    } else {
        if (status.isMatch) {
            [text appendFormat:@" matched, %d points", status.score];
        } else {
            [text appendFormat:@" did't match, %d points", status.score];
        }
    }

    return [[NSMutableAttributedString alloc] initWithString:text];
}

- (IBAction)flipCard:(UIButton *)sender
{    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self.gameMatchMode setEnabled:NO];
    [self.gameMatchHistory setEnabled:YES];
    self.gameMatchHistory.maximumValue++;
    self.gameMatchHistory.value = self.gameMatchHistory.maximumValue;
    [self updateUI];
}

- (void)initialSetup
{
    UIImage *emptyImage = [[UIImage alloc] init];

    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [cardButton setImage:emptyImage
                    forState:UIControlStateSelected];
        [cardButton setImage:emptyImage
                    forState:UIControlStateSelected | UIControlStateDisabled];
        [cardButton setImage:emptyImage
                    forState:UIControlStateSelected | UIControlStateHighlighted];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetup];
    [self updateGameMode:self.gameMatchMode.selectedSegmentIndex + 2];
    self.gameMatchHistory.minimumValue = 0;
    self.gameMatchHistory.maximumValue = 0;
    [self updateUI];
}

@end
