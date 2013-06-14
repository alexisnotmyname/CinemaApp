//
//  CheckinVC.h
//  sureseats
//
//  Created by chocowin on 5/30/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "FBShareVC.h"

@interface CheckinVC : UIViewController{
    UIViewController *initViewController;

}
- (IBAction)fbPress:(id)sender;

@property (strong, nonatomic) NSString *movieTitle;

@end
