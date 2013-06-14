//
//  FBShareVC.m
//  sureseats
//
//  Created by chocowin on 5/31/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "FBShareVC.h"

@interface FBShareVC (){
    MBProgressHUD *HUD;
}

@end

@implementation FBShareVC
@synthesize locationManager = _locationManager;
@synthesize placePickerController = _placePickerController;
@synthesize selectedPlace = _selectedPlace;

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
    [FBProfilePictureView class];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
    else{
        //this will login the user to fb
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate openSessionWithAllowLoginUI:YES];
        [self populateUserDetails];
    }
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
    
    self.shareTextView.text = [NSString stringWithFormat:@"is watching %@",self.movieTitle];
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    // We don't want to be notified of small changes in location,
    // preferring to use our last cached results, if any.
    self.locationManager.distanceFilter = 50;
    [self.locationManager startUpdatingLocation];

}
- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.nameLabel.text = user.name;
                 self.profileImage.profileID = user.id;

             }
         }];
    }
}

- (void)sessionStateChanged:(NSNotification*)notification {
    [self populateUserDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc{
    _locationManager.delegate = nil;
}

- (IBAction)logoutPress:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkinPress:(id)sender {
    self.placePickerController.delegate = self;
    
    if (!self.placePickerController) {
        self.placePickerController = [[FBPlacePickerViewController alloc]
                                      initWithNibName:nil bundle:nil];
        self.placePickerController.title = @"Check-in to place";
    }
    self.placePickerController.locationCoordinate = self.locationManager.location.coordinate;
    self.placePickerController.radiusInMeters = 1000;
    self.placePickerController.resultsLimit = 50;
    self.placePickerController.searchText = @"";
    
    [self.placePickerController loadData];
    //    [self presentViewController:self.placePickerController animated:YES completion:nil];
    [self.placePickerController presentModallyFromViewController:self
                                                        animated:YES
                                                         handler:^(FBViewController *sender, BOOL donePressed) {
                                                             if (donePressed) {
                                                                 self.selectedPlace = self.placePickerController.selection;
                                                                 self.placeTextView.text = self.selectedPlace.name;
                                                             }
                                                         }];
}

#pragma mark -CLLocationManager Delegates
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (!oldLocation ||
        (oldLocation.coordinate.latitude != newLocation.coordinate.latitude &&
         oldLocation.coordinate.longitude != newLocation.coordinate.longitude)) {
            
            // To-do, add code for triggering view controller update
            NSLog(@"Got location: %f, %f",
                  newLocation.coordinate.latitude,
                  newLocation.coordinate.longitude);
        }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

#pragma mark -FBPlacePicker Delegate
- (void)placePickerViewControllerSelectionDidChange:
(FBPlacePickerViewController *)placePicker
{
    //    self.selectedPlace = placePicker.selection;
    //    if (self.selectedPlace.count > 0) {
    //        self.textViewLocation.text = self.selectedPlace.name;
    //    }
}

- (IBAction)sharePress:(id)sender {
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Posting to Wall";
    
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:self.shareTextView.text forKey:@"message"];
    [postParams setObject:self.selectedPlace.id forKey:@"place"];
    
    [FBRequestConnection
     startWithGraphPath:@"me/feed"
     parameters:postParams
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *alertText;
         if (error) {
             alertText = [NSString stringWithFormat:
                          @"error: domain = %@, code = %d",
                          error.domain, error.code];
         } else {
             alertText = @"Posted successfully.";
         }
         // Show the result in an alert
         [[[UIAlertView alloc] initWithTitle:@"Result"
                                     message:alertText
                                    delegate:self
                           cancelButtonTitle:@"OK!"
                           otherButtonTitles:nil]
          show];
     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end
