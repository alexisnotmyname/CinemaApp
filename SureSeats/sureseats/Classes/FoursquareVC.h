//
//  FoursquareVC.h
//  sureseats
//
//  Created by Sharan Balani on 5/30/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Foursquare2.h"
#import "FSConverter.h"
@class FSVenue;

@interface FoursquareVC : UITableViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (strong,nonatomic)FSVenue* selected;
@property (strong,nonatomic)NSArray* nearbyVenues;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *logButton;
@property (strong, nonatomic) IBOutlet UIView *footerView;

- (IBAction)checkInClicked:(id)sender;
- (IBAction)logInOut:(id)sender;

-(void)checkIn;
-(void)checkLogStatus;

@end
