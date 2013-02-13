//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Kevin Tong on 2/12/13.
//  Copyright (c) 2013 Kevin Tong. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

// Match Game Settings
@property (weak, nonatomic) IBOutlet UISlider *gameMatchBGSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMatchTextSegControl;
@property (weak, nonatomic) IBOutlet UIImageView *gameMatchSampleBG;
@property (weak, nonatomic) IBOutlet UILabel *gameMatchSampleText;

// Set Game Settings
@property (weak, nonatomic) IBOutlet UISlider *gameSetBGSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSetTextSegControl;
@property (weak, nonatomic) IBOutlet UIImageView *gameSetSampleBG;
@property (weak, nonatomic) IBOutlet UILabel *gameSetSampleText;
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

@end
