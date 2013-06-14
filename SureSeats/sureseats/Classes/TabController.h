//
//  TabController.h
//  
//
//  Created by Martin on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TabController : UITabBarController <UINavigationControllerDelegate,UIAlertViewDelegate>{
    NSMutableArray *_listTabImages;
    NSMutableArray *_listControllers;
    NSMutableArray *_listTabButtons;
    UINavigationController *_navigationController;
}
@property (nonatomic, assign) int activeIndex;
@end
