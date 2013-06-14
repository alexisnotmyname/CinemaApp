//
//  MoviesNC.h
//  sureseats
//
//  Created by Martin on 5/27/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailsVC.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface MoviesVC : UIViewController<NSXMLParserDelegate>{
    NSArray *movieList;
}

@property (strong, nonatomic) IBOutlet UITableView *movieListTableView;
@end
