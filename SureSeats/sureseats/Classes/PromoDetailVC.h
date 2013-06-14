//
//  PromoDetailVC.h
//  sureseats
//
//  Created by chocowin on 5/30/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface PromoDetailVC : UIViewController

@property (strong, nonatomic) NSMutableArray *promos;
@property (strong, nonatomic) NSDictionary *promoDetails;


@property (strong, nonatomic) IBOutlet UIImageView *promoImageView;
@property (strong, nonatomic) IBOutlet UILabel *mallNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@end
