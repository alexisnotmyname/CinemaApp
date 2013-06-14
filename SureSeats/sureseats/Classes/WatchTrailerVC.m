//
//  WatchTrailerVC.m
//  sureseats
//
//  Created by Sharan Balani on 6/3/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "WatchTrailerVC.h"

@interface WatchTrailerVC ()

@end

@implementation WatchTrailerVC
@synthesize trailerWebView;
@synthesize movieTrailerUrl;

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
//    NSString *embed2 = @"<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/mDFKyp40XUc\" frameborder=\"0\" allowfullscreen></iframe>";
    NSString *embed = [NSString stringWithFormat:@"<iframe class=\"youtube-player\" type=\"text/html\" width=\"260\" height=\"180\" src=\"http://www.youtube.com/embed/%@\" frameborder=\"0\"></iframe>", movieTrailerUrl];
    trailerWebView.scrollView.scrollEnabled = NO;
    [trailerWebView loadHTMLString:embed baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
