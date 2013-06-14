//
//  AppDelegate.h
//  sureseats
//
//  Created by Martin on 5/27/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "CheckinVC.h"
#import "FBShareVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UIViewController *initViewController;

}
@property (strong, nonatomic) UINavigationController* navController;

@property (strong, nonatomic) UIWindow *window;
extern NSString *const FBSessionStateChangedNotification;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
@end
