//
//  TabController.m
//  
//
//  Created by Martin on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TabController.h"
#import "MoviesVC.h"
#import "CinemaVC.h"
#import "PromoVC.h"
#import "ProfileVC.h"

@implementation TabController
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewWillDisappear:(BOOL)animated{

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static BOOL didShow = NO;
    if (!didShow) {
        NSMutableArray *listControllers = [[NSMutableArray alloc]init];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        MoviesVC *controller1 = (MoviesVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"movies-vc"];
        _navigationController =[[UINavigationController alloc]initWithRootViewController:controller1];
        _navigationController.title = @"Movies";
        _navigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarInspiration"];
        _navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [listControllers addObject:_navigationController];
        
        CinemaVC *controller2 = (CinemaVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"cinema-vc"];
        _navigationController = [[UINavigationController alloc]initWithRootViewController:controller2];
        _navigationController.title = @"Cinema";
        _navigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarWhatsHot"];
        _navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [listControllers addObject:_navigationController];
        
        PromoVC *controller3 = (PromoVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"promo-vc"];
        _navigationController = [[UINavigationController alloc]initWithRootViewController:controller3];
        _navigationController.title = @"Promos";
        _navigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarWhatsHot"];
        _navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [listControllers addObject:_navigationController];
        
        ProfileVC *controller4 = (ProfileVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"profile-vc"];
        _navigationController = [[UINavigationController alloc]initWithRootViewController:controller4];
        _navigationController.title = @"Profile";
        _navigationController.tabBarItem.image = [UIImage imageNamed:@"tabBarWhatsHot"];
        _navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [listControllers addObject:_navigationController];
    
    self.viewControllers = listControllers;
    //    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBG.png"]];
    //    background.frame = CGRectMake(0, 0, 320, 480);
    //    [self.view insertSubview:background atIndex:0];
    
//    UIImageView *tabBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBarBG"]];
//    [tabBackground setFrame:CGRectMake(0, self.view.frame.size.height-58, 320, 63)];
//    [self.view addSubview:tabBackground];
    
    //Prepare image names for buttonItems
    _listTabImages = [[NSMutableArray alloc]init];
    [_listTabImages addObject:@"tabBarInspiration"];
    [_listTabImages addObject:@"tabBarWhatsHot"];
    [_listTabImages addObject:@"tabBarWeLove"];
    [_listTabImages addObject:@"tabBarOffer"];
    [_listTabImages addObject:@"tabBarSearch"];
    
    [self setupTabBar];
    [self setActiveIndex:0];
    didShow = YES;
}
}

-(void)setupTabBar{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UITabBar class]]){
            view.hidden = YES;
        }
    }
    int count = [self.viewControllers count];
    float xWidth = 320 / count;
    float yCenter = 450.0f;
//    float yCenter = (![[GameHandler sharedInstance]hasTallScreen])?450.0f:568.0f - 30.0f;

    _listTabButtons = [[NSMutableArray alloc]init];
    for(int i = 0; i <count; i++){
        float x = xWidth * i + xWidth / 2;
        float y = yCenter;
        
        UINavigationController *navCtrl = [self.viewControllers objectAtIndex:i];
        UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabButton.frame = CGRectMake(0, 48, navCtrl.tabBarItem.image.size.width-2, navCtrl.tabBarItem.image.size.height+6);
        UIImage *image = nil;
        if (i == 0 )
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_p.png",[_listTabImages objectAtIndex:i]]];
        else
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[_listTabImages objectAtIndex:i]]];
        
        [tabButton setCenter:CGPointMake(x, y+3)];
        [tabButton addTarget:self action:@selector(pressTab:) forControlEvents:UIControlEventTouchUpInside];
        [_listTabButtons addObject:tabButton];
        [self.view addSubview:tabButton];
    }
    
}

- (void)pressTab:(UIButton *)sender{
    int idx = [_listTabButtons indexOfObject:sender];
    [self setActiveIndex:idx];
//    UINavigationController *navCtrl = [self.viewControllers objectAtIndex:idx];
//    NSString *menuTitle = navCtrl.title;
//    [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Tab" withAction:@"Press" withLabel:@"Tab Pressed" withValue:[NSNumber numberWithInt:idx]];
//    [Flurry logEvent:@"Tab Pressed" withParameters:@{menuTitle:@"Menu Title"}];
}

- (void)setActiveIndex:(int)activeIndex{
    static int tempIndex = -1;
    if(tempIndex != activeIndex){
        tempIndex = activeIndex;
        _activeIndex = tempIndex;
        [self setSelectedIndex:activeIndex];
        //Find active button and set selected image
        for(int i=0; i<_listTabButtons.count; i++){
            UIButton *button = [_listTabButtons objectAtIndex:i];
            if (activeIndex == i) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_p.png",[_listTabImages objectAtIndex:i]]];
                [button setImage:image forState:UIControlStateNormal];
            }
            else{
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[_listTabImages objectAtIndex:i]]];
                [button setImage:image forState:UIControlStateNormal];
            }
        }
    }
}
@end
