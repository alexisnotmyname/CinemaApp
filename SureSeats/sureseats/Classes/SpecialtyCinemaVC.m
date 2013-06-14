//
//  SpecialtyCinemaVC.m
//  sureseats
//
//  Created by Sharan Balani on 6/4/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "SpecialtyCinemaVC.h"

@interface SpecialtyCinemaVC ()

@end

@implementation SpecialtyCinemaVC
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

//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    [self.scrollView setContentSize:CGSizeMake(320, 808)];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
