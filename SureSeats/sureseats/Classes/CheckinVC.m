//
//  CheckinVC.m
//  sureseats
//
//  Created by chocowin on 5/30/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "CheckinVC.h"

@interface CheckinVC ()

@end

@implementation CheckinVC

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.r
}

- (IBAction)fbPress:(id)sender {
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    [appDelegate openSessionWithAllowLoginUI:YES];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"fbShare"]) {
        FBShareVC *vc = [[FBShareVC alloc] init];
        vc = [segue destinationViewController];
        vc.movieTitle = self.movieTitle;
    }
}


@end
