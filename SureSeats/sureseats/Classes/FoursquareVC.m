//
//  FoursquareVC.m
//  sureseats
//
//  Created by Sharan Balani on 5/30/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "FoursquareVC.h"
#import "FSVenue.h"

@interface FoursquareVC ()

@end

@implementation FoursquareVC
@synthesize footerView;
@synthesize logButton;

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
    
    self.tableView.tableFooterView = self.footerView;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    [self checkLogStatus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - CCLocation Delegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    [locationManager stopUpdatingLocation];
    [self getVenuesForLocation:newLocation];
}

#pragma mark - Foursquare2 Methods

-(void)getVenuesForLocation:(CLLocation*)location{
    [Foursquare2 searchVenuesNearByLatitude:@(location.coordinate.latitude)
								  longitude:@(location.coordinate.longitude)
								 accuracyLL:nil
								   altitude:nil
								accuracyAlt:nil
									  query:nil
									  limit:nil
									 intent:intentCheckin
                                     radius:@(500)
                                 categoryId:nil
								   callback:^(BOOL success, id result){
									   if (success) {
										   NSDictionary *dic = result;
										   NSArray* venues = [dic valueForKeyPath:@"response.venues"];
                                           FSConverter *converter = [[FSConverter alloc]init];
                                           self.nearbyVenues = [converter convertToObjects:venues];
                                           [self.tableView reloadData];
									   }
								   }];
}

-(void)userDidSelectVenue{
    if ([Foursquare2 isAuthorized]) {
        [self checkIn];
	}else{
        [Foursquare2 authorizeWithCallback:^(BOOL success, id result) {
            if (success) {
				[Foursquare2  getDetailForUser:@"self" callback:^(BOOL success, id result){
                    if (success) {
                        [self checkLogStatus];
                        [self checkIn];
                    }
                }];
			}
        }];
    }
}

- (void)checkIn{
    [Foursquare2  createCheckinAtVenue:self.selected.venueId
                                 venue:nil
                                 shout:@"Testing"
                             broadcast:broadcastPublic
                              latitude:nil
                             longitude:nil
                            accuracyLL:nil
                              altitude:nil
                           accuracyAlt:nil
                              callback:^(BOOL success, id result){
                                  if (success) {
                                      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Check-in"
                                                                                     message:@"Success"
                                                                                    delegate:self
                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                      [alert show];
                                  }
                              }];
}

-(void)checkLogStatus{
    if ([Foursquare2 isAuthorized]) {
        logButton.title = @"Logout";
    }
    else{
        logButton.title = @"Login";
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nearbyVenues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    for (UIView *view in [cell.contentView subviews])
    {
        [view removeFromSuperview];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(checkInClicked:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Check-in" forState:UIControlStateNormal];
    button.frame = CGRectMake(cell.frame.size.width - 80, 7.0f, 70.0f, 30.0f);
    button.tag = indexPath.row;
    [cell addSubview:button];
    
    FSVenue *venue = self.nearbyVenues[indexPath.row];
    
    UILabel *venueLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 0.0f, cell.frame.size.width - 90, 24.0f)];
    venueLabel.text = [self.nearbyVenues[indexPath.row] name];
    [cell.contentView addSubview:venueLabel];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 24.0f, cell.frame.size.width - 90.0f, cell.frame.size.height - 25.0f)];
    locationLabel.font = [UIFont systemFontOfSize:14.0];
    locationLabel.textColor = [UIColor lightGrayColor];
    
    if (venue.location.address) {
        locationLabel.text = [NSString stringWithFormat:@"%@m, %@",
                              venue.location.distance,
                              venue.location.address];
    }else{
        locationLabel.text = [NSString stringWithFormat:@"%@m",
                              venue.location.distance];
    }
    
    [cell.contentView addSubview:locationLabel];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - IBActions

-(IBAction)checkInClicked:(id)sender{
    self.selected = self.nearbyVenues[[sender tag]];
    [self userDidSelectVenue];
}

- (IBAction)logInOut:(id)sender {
    if ([logButton.title isEqualToString:@"Login"]) {
        [Foursquare2 authorizeWithCallback:^(BOOL success, id result) {
            if (success) {
				[Foursquare2  getDetailForUser:@"self" callback:^(BOOL success, id result){
                    if (success) {
                        [self checkLogStatus];
                    }
                }];
			}
        }];
    }
    else{
        [Foursquare2 removeAccessToken];
        [self checkLogStatus];
    }
}
@end
