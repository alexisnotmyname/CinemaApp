//
//  AccountRegisterVC.m
//  sureseats
//
//  Created by chocowin on 6/4/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "AccountRegisterVC.h"

@interface AccountRegisterVC ()

@end

@implementation AccountRegisterVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.passwordVerifyTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.mobileNoTextField.delegate = self;
    self.myTheaterTextField.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.tableView scrollRectToVisible:((UIView *)textField).superview.superview.frame animated:YES];
}






@end
