//
//  SetCard.m
//  Matchismo
//
//  Created by Kevin Tong on 2/9/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;

    if ([otherCards count] == 2) {
        // make sure other cards are SetCards
        for (id otherCard in otherCards) {
            if (![otherCard isKindOfClass:[SetCard class]]) {
                return score;
            }
        }
        SetCard *card2 = otherCards[0];
        SetCard *card3 = otherCards[1];

        // match by number
        if (card2.number == card3.number) {
            if (self.number != card2.number) {
                return score; // score = 0
            }
        } else if (self.number == card2.number ||
                   self.number == card3.number) {
            return score; // score = 0
        }

        // match by shading
        if (card2.shading == card3.shading) {
            if (self.shading != card2.shading) {
                return score; // score = 0
            }
        } else if (self.shading == card2.shading ||
                   self.shading == card3.shading) {
            return score; // score = 0
        }

        // match by color
        if (card2.color == card3.color) {
            if (self.color != card2.color) {
                return score; // score = 0
            }
        } else if (self.color == card2.color ||
                   self.color == card3.color) {
            return score; // score = 0
        }
        
        // match by symbol
        if ([card2.symbol isEqualToString:card3.symbol]) {
            if (![self.symbol isEqualToString:card2.symbol]) {
                return score; // score = 0
            }
        } else if ([self.symbol isEqualToString:card2.symbol] ||
                   [self.symbol isEqualToString:card3.symbol]) {
            return score; // score = 0
        }
        
        score = 1;
    }

    return score;
}

// contents represent symbol and number only
- (NSString *)contents
{
    return [@"" stringByPaddingToLength:self.number
                             withString:self.symbol startingAtIndex:0];
}

// HAVE to synthesize because setter AND getter was implemented
@synthesize symbol = _symbol;

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setNumber:(NSUInteger)number
{
    if ( number > 0 && number <= [SetCard maxVariation]) {
        _number = number;
    }
}

- (void)setShading:(NSUInteger)shading
{
    if ( shading > 0 && shading <= [SetCard maxVariation]) {
        _shading = shading;
    }
}

- (void)setColor:(NSUInteger)color
{
    if ( color > 0 && color <= [SetCard maxVariation]) {
        _color = color;
    }
}

+ (NSArray *)validSymbols
{
    static NSArray *validSymbols = nil;

    if (!validSymbols) {
        validSymbols = @[@"▲", @"■", @"●"];
    }

    return validSymbols;
}

+ (NSUInteger)maxVariation
{
    return 3;
}

- (id)copyWithZone:(NSZone *)zone
{
    SetCard *copy = [super copyWithZone:zone];

    if (copy) {
        copy.symbol  = [self.symbol copyWithZone:zone];
        copy.number  = self.number;
        copy.shading = self.shading;
        copy.color   = self.color;
    }

    return copy;
}

@end
