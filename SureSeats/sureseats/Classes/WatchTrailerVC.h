//
//  WatchTrailerVC.h
//  sureseats
//
//  Created by Sharan Balani on 6/3/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchTrailerVC : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *trailerWebView;
@property(strong, nonatomic)NSString *movieTrailerUrl;

@end
