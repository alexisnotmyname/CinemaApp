//
//  PromoVC.m
//  sureseats
//
//  Created by Martin on 5/27/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "PromoVC.h"

@interface PromoVC (){
    NSDictionary *dict;
    NSMutableArray *test;
}

@end

@implementation PromoVC
@synthesize promoTableVIew;

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
//    promos = [[NSMutableArray alloc] initWithObjects:@"Promo 1", @"Promo 2", @"Promo 3", nil];
    [self.navigationItem setTitle:@"Promos and Event"];
    [super viewDidLoad];
    
    promos = [[NSMutableArray alloc] init];
    test = [[NSMutableArray alloc] init];
    [self fetchPromosFromWeb];
}

-(void)fetchPromosFromWeb{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSString *urlString = @"http://ayala360.net/api/v1/malls";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         NSLog(@"success");
         promos = [JSON valueForKeyPath:@"name"];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         [self.promoTableVIew reloadData];
         test = JSON;
     }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
     {
         UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Feeds"
                                                      message:[NSString stringWithFormat:@"%@",error]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [av show];
         NSLog(@"%@",error);
     }];
    
    [operation start];
}


#pragma mark -Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return promos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //    if(cell == nil){
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //    }
    cell.textLabel.text = [promos objectAtIndex:indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"promoDetail"]){
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *ip = [promoTableVIew indexPathForCell:cell];
        
        PromoDetailVC *vc = (PromoDetailVC*)[segue destinationViewController];
        vc.promos = [test objectAtIndex:ip.row];

        //        NSString *promoName = [promos objectAtIndex:ip.row];
//        [vc.navigationItem setTitle:promoName];
    }
}


@end
