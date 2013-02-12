//
//  SetCard.h
//  Matchismo
//
//  Created by Kevin Tong on 2/9/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card  <NSCopying>

@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;

+ (NSArray *)validSymbols;
+ (NSUInteger)maxVariation;

@end
