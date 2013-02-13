//
//  SetCard.h
//  Matchismo
//
//  Created by Kevin Tong on 2/9/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "Card.h"

typedef NS_ENUM(NSUInteger, SetCardSymbol) {
    SetCardSymbolInvalid  = 0,
    SetCardSymbolDiamond  = 1,
    SetCardSymbolSquiggle = 2,
    SetCardSymbolOval     = 3
};

typedef NS_ENUM(NSUInteger, SetCardShading) {
    SetCardShadingInvalid = 0,
    SetCardShadingSolid   = 1,
    SetCardShadingStriped = 2,
    SetCardShadingOpen    = 3    
};

typedef NS_ENUM(NSUInteger, SetCardColor) {
    SetCardColorInvalid = 0,
    SetCardColorRed     = 1,
    SetCardColorGreen   = 2,
    SetCardColorPurple  = 3
};

@interface SetCard : Card  <NSCopying>

@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;

- (SetCardSymbol)symbolValue;
+ (NSArray *)validSymbols;
+ (NSUInteger)maxVariation;

@end
