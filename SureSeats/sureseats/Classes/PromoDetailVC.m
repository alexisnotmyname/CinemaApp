//
//  PromoDetailVC.m
//  sureseats
//
//  Created by chocowin on 5/30/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "PromoDetailVC.h"

@interface PromoDetailVC (){
}

@end

@implementation PromoDetailVC
@synthesize promoDetails, promos;

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
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 580);
    NSString *urlImagePath = [NSString stringWithFormat:@"http://%@",[promos valueForKeyPath:@"photo_url"]];
    NSURL *urlImage = [NSURL URLWithString:urlImagePath];
    [self.promoImageView setImageWithURL:urlImage];
    
    self.mallNameLabel.text = [promos valueForKeyPath:@"name"];
    self.phoneNumLabel.text = [promos valueForKeyPath:@"phone_number"];
    self.descriptionTextView.text = [promos valueForKeyPath:@"description"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
