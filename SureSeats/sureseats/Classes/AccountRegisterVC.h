//
//  AccountRegisterVC.h
//  sureseats
//
//  Created by chocowin on 6/4/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountRegisterVC : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordVerifyTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *mobileNoTextField;
@property (strong, nonatomic) IBOutlet UITextField *myTheaterTextField;


@end
