//
//  BuyTicketVC.m
//  sureseats
//
//  Created by Sharan Balani on 6/3/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "BuyTicketVC.h"

#define PickerHeight 216
#define PickerToolbarHeight 44

@interface BuyTicketVC ()

@end

@implementation BuyTicketVC
@synthesize mallTextField, cinemaTextField, timeTextField;
@synthesize movieTitle;

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
	NSString *plistFile = [[NSBundle mainBundle] pathForResource:@"CinemaList" ofType:@"plist"]; //setting the path
    pListContent = [NSDictionary dictionaryWithContentsOfFile:plistFile];
    mall = [[NSArray alloc] initWithArray:[pListContent objectForKey:@"Malls"]];
    cinema = [[NSArray alloc] initWithArray:[pListContent objectForKey:@"Cinemas"]];
    availableCinemasForSelectedMovie = [[NSMutableArray alloc] init];
    availableTimeForSelectedCinema = [[NSMutableArray alloc] init];
    
    /*=============Pickers===============*/
    mallPickerView = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 44, 320, PickerHeight)];
    mallPickerView.tag = 1;
    mallPickerView.delegate = self;
    mallPickerView.dataSource = self;
    
    cinemaPickerView = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 44, 320, PickerHeight)];
    cinemaPickerView.tag = 2;
    cinemaPickerView.delegate = self;
    cinemaPickerView.dataSource = self;
    
    timePickerView = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 44, 320, PickerHeight)];
    timePickerView.tag = 3;
    timePickerView.delegate = self;
    timePickerView.dataSource = self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, PickerHeight, 320, PickerToolbarHeight)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style: UIBarButtonItemStyleBordered target: self action: @selector(pressedDoneButton:)];
    
    cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style: UIBarButtonItemStyleBordered target: self action: @selector(pressedCancelButton:)];
    toolbar.items = [NSArray arrayWithObjects:doneButton, cancelButton,nil];
    
    /*=============TextFields===============*/
    mallTextField.inputView = mallPickerView;
    mallTextField.inputAccessoryView = toolbar;
    
    cinemaTextField.inputView = cinemaPickerView;
    cinemaTextField.inputAccessoryView = toolbar;
    
    timeTextField.inputView = timePickerView;
    timeTextField.inputAccessoryView = toolbar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - Picker Datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int row = 1;
    if(pickerView.tag == 1){
        row = mall.count;
    }
    else if(pickerView.tag == 2){
        if ([availableCinemasForSelectedMovie count] != 0) {
            row = availableCinemasForSelectedMovie.count;
        }
        else{
            row = 1;
        }
    }
    else if (pickerView.tag == 3){
        if ([availableTimeForSelectedCinema count] != 0) {
            row = availableTimeForSelectedCinema.count;
        }
        else{
            row = 1;
        }
    }
    return row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = nil;
    if(pickerView.tag == 1)
        title = [mall objectAtIndex:row];
    else if(pickerView.tag == 2){
        if ([availableCinemasForSelectedMovie count] != 0) {
            title = [[availableCinemasForSelectedMovie objectAtIndex:row] objectForKey:@"Cinema Number"];
        }
        else{
            title = @"None";
        }
    }
    else{
        if ([availableCinemasForSelectedMovie count] != 0) {
            title = [availableTimeForSelectedCinema objectAtIndex:row];
        }
        else{
            title = @"None";
        }
    }
    return title;
}

#pragma - Picker Delagate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    ;
    if(pickerView.tag == 1){
        selectedMall = [mall objectAtIndex:row];
        [self getAvailableCinemas:row];
        [cinemaPickerView reloadAllComponents];
    }
    if(pickerView.tag == 2){
        
        if([availableCinemasForSelectedMovie count] != 0){
            selectedCinema = [[availableCinemasForSelectedMovie objectAtIndex:row] objectForKey:@"Cinema Number"];
            [self getAvailableTime:row];
            [timePickerView reloadAllComponents];
        }
    }
    if(pickerView.tag == 3){
        if([availableTimeForSelectedCinema count] != 0){
            selectedTime = [availableTimeForSelectedCinema objectAtIndex:row];
        }
    }
}

#pragma - TextField Delagate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField { //For setting the defualt values

    if (textField.tag == 1) {
        selectedMall = [mall objectAtIndex:0];
        doneButton.tag = 1;
        [self getAvailableCinemas:0];
        [cinemaPickerView reloadAllComponents];
    }
    else if(textField.tag == 2) {
        if([availableCinemasForSelectedMovie count] != 0){
            selectedCinema = [[availableCinemasForSelectedMovie objectAtIndex:0] objectForKey:@"Cinema Number"];
            doneButton.tag = 2;
            [self getAvailableTime:0];
            [timePickerView reloadAllComponents];
        }
    }
    else {
        if([availableTimeForSelectedCinema count] != 0){
            selectedTime = [availableTimeForSelectedCinema objectAtIndex:0];
            doneButton.tag = 3;
        }
    }
    
    return  YES;
}

#pragma - Methods

- (void)getAvailableCinemas:(NSInteger) row{
    [availableCinemasForSelectedMovie removeAllObjects];
    for(int i=0; i<[[cinema objectAtIndex:row] count]; i++){
        if ([movieTitle isEqualToString:[[[cinema objectAtIndex:row] objectAtIndex:i] objectForKey:@"Movie Title"]]) {
            [availableCinemasForSelectedMovie addObject:[[cinema objectAtIndex:row] objectAtIndex:i]];
        }
    }
}

- (void)getAvailableTime:(NSInteger) row{
    [availableTimeForSelectedCinema removeAllObjects];
    [availableTimeForSelectedCinema addObjectsFromArray:[[availableCinemasForSelectedMovie objectAtIndex:row] objectForKey:@"Time"]];
}


#pragma - IBAction

- (void)pressedDoneButton:(UIBarButtonItem *)sender{
    if (sender.tag == 1) {
        mallTextField.text = selectedMall;
        cinemaTextField.text = @"";
        cinemaTextField.enabled = YES;
        timeTextField.text = @"";
        timeTextField.enabled = NO;
    }
    else if (sender.tag  == 2){
        cinemaTextField.text = selectedCinema;
        timeTextField.enabled = YES;
    }
    else if(sender.tag == 3){
        timeTextField.text = selectedTime;
    }
    
    [self.view.window endEditing:YES];
}

- (void)pressedCancelButton:(UIBarButtonItem *)sender{
    [self.view.window endEditing:YES];
}

@end
