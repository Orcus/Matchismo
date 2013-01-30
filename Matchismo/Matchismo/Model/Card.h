//
//  Card.h
//  Matchismo
//
//  Created by Kevin on 1/28/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(Card *)card;

@end
