//
//  AccountsLoginVC.m
//  sureseats
//
//  Created by chocowin on 5/30/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "AccountsLoginVC.h"

@interface AccountsLoginVC ()

@end

@implementation AccountsLoginVC
@synthesize usernameTextField, passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

@end
