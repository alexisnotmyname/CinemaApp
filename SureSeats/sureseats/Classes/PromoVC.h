//
//  PromoVC.h
//  sureseats
//
//  Created by Martin on 5/27/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromoDetailVC.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface PromoVC : UIViewController{
    NSMutableArray *promos;
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UITableView *promoTableVIew;

@end
