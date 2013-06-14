//
//  OnStageCinemaVC.m
//  sureseats
//
//  Created by Sharan Balani on 6/4/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "OnStageCinemaVC.h"

@interface OnStageCinemaVC ()

@end

@implementation OnStageCinemaVC
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	scrollView.contentSize = CGSizeMake(320, 700);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
