//
//  FBShareVC.h
//  sureseats
//
//  Created by chocowin on 5/31/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface FBShareVC : UIViewController<CLLocationManagerDelegate, FBPlacePickerDelegate, UITextViewDelegate>{
}

- (IBAction)logoutPress:(id)sender;
- (IBAction)cancelPress:(id)sender;
- (IBAction)checkinPress:(id)sender;
- (IBAction)sharePress:(id)sender;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UITextView *placeTextView;
@property (strong, nonatomic) IBOutlet UITextView *shareTextView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) FBPlacePickerViewController *placePickerController;
@property (strong, nonatomic) NSObject<FBGraphPlace>* selectedPlace;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSString *movieTitle;


@end
