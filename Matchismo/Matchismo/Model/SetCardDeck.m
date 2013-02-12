//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Kevin Tong on 2/9/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];

    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSUInteger number = 1; number <= [SetCard maxVariation]; number++) {
                for (NSUInteger shading = 1; shading <= [SetCard maxVariation]; shading++) {
                    for (NSUInteger color = 1; color <= [SetCard maxVariation]; color++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.number = number;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card atTop:NO];
                        //NSLog(@"%@,n:%d,s:%d,c:%d", card.symbol, card.number, card.shading, card.color);
                    }
                }
            }
        }
    }

    return self;
}

@end
