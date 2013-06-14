//
//  MovieDetailsVC.h
//  sureseats
//
//  Created by chocowin on 5/30/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckinVC.h"

@interface MovieDetailsVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *movieDescriptionTextView;
@property (strong, nonatomic) NSString *movieTitle, *movieDescription, *movieTrailerUrl;
@end
