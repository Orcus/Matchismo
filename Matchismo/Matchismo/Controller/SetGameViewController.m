//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Kevin Tong on 2/9/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSArray *cardSetColors;
@property (strong, nonatomic) UIColor *highlightColor;
@end

@implementation SetGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]];
        _game.matchBonus = 6;
    }
    return _game;
}

- (NSArray *)cardSetColors
{
    if (!_cardSetColors) {
        _cardSetColors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    }
    return _cardSetColors;
}

- (UIColor *)highlightColor
{
    if (!_highlightColor) {
        _highlightColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    }
    return _highlightColor;
}

- (void)updateCards
{
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:card.contents];

        [title setAttributes:[self cardSetAttributes:card]
                       range:NSMakeRange(0, title.length)];

        [cardButton setAttributedTitle:title
                              forState:UIControlStateSelected];
        [cardButton setAttributedTitle:title
                              forState:UIControlStateNormal];

        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        [cardButton setBackgroundColor:cardButton.isSelected ?
                    self.highlightColor : [UIColor whiteColor]];
        cardButton.alpha = card.isUnplayable ? 0.0 : 1.0;
    }
}

- (NSDictionary *)cardSetAttributes:(SetCard *)card
{
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    if (card.shading == SetCardShadingSolid) {
        [attributes setObject:self.cardSetColors[card.color - 1]
                       forKey:NSForegroundColorAttributeName];
    } else {
        if (card.shading == SetCardShadingStriped) {
            [attributes setObject:[UIColor lightGrayColor]
                           forKey:NSForegroundColorAttributeName];
        } else {
            [attributes setObject:[UIColor whiteColor]
                           forKey:NSForegroundColorAttributeName];
        }

        [attributes setObject:self.cardSetColors[card.color - 1]
                       forKey:NSStrokeColorAttributeName];
        [attributes setObject:@-10
                       forKey:NSStrokeWidthAttributeName];
    }

    return attributes;
}

- (NSAttributedString *)historyText:(MatchStatus *)status
{
    NSString *separator = @"&";
    NSArray *cards = [status group];
    NSMutableString *text = [[NSMutableString alloc]
                             initWithString:[cards componentsJoinedByString:separator]];


    if ([cards count] == 1) {
        if (status.isFlip) {
            [text appendFormat:@" selected, %d point", status.score];
        } else {
            [text appendString:@" unselected"];
        }
    } else {
        if (status.isMatch) {
            [text appendFormat:@" matched, %d points", status.score];
        } else {
            [text appendFormat:@" did't match, %d points", status.score];
        }
    }

    NSMutableAttributedString *textAtt = [[NSMutableAttributedString alloc] initWithString:text];
    int index = 0; // index of each card's text

    for (SetCard *card in cards) {
        NSDictionary *attributes = [self cardSetAttributes:card];
        [textAtt setAttributes:attributes range:NSMakeRange(index, card.number)];
        index += card.number + separator.length;
    }

    return textAtt;
}

- (void)updateGameMode:(NSUInteger)mode
{
    // Set always matches with 3 cards
    self.game.cardsToMatch = 3;
}

- (void)initialSetup
{
}
@end
