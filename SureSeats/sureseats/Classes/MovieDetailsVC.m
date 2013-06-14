//
//  MovieDetailsVC.m
//  sureseats
//
//  Created by chocowin on 5/30/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "MovieDetailsVC.h"
#import "BuyTicketVC.h"
#import "WatchTrailerVC.h"

@interface MovieDetailsVC ()

@end

@implementation MovieDetailsVC
@synthesize movieTitleLabel;
@synthesize movieDescriptionTextView;
@synthesize movieTitle, movieDescription, movieTrailerUrl;

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
    movieTitleLabel.text = movieTitle;
    movieDescriptionTextView.text = movieDescription;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"BuyTicket"]) {
        BuyTicketVC *vc = [[BuyTicketVC alloc] init];
        vc = [segue destinationViewController];
        vc.movieTitle = movieTitle;
        [vc.navigationItem setTitle:movieTitle];
    }
    else if ([[segue identifier] isEqualToString:@"WatchTrailer"]) {
        WatchTrailerVC *vc = [[WatchTrailerVC alloc] init];
        vc = [segue destinationViewController];
        vc.movieTrailerUrl = movieTrailerUrl;
        [vc.navigationItem setTitle:movieTitle];
    }
    else if ([segue.identifier isEqualToString:@"CheckIn"]) {
        CheckinVC *vc = [[CheckinVC alloc] init];
        vc = [segue destinationViewController];
        vc.movieTitle = movieTitle;
    }

}

@end
