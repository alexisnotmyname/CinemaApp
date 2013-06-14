//
//  BuyTicketVC.h
//  sureseats
//
//  Created by Sharan Balani on 6/3/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyTicketVC : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *mall, *cinema;
    NSMutableArray *availableCinemasForSelectedMovie, *availableTimeForSelectedCinema;
    NSDictionary *pListContent;
    UIPickerView *mallPickerView, *cinemaPickerView, *timePickerView;
    NSString *selectedMall, *selectedCinema, *selectedTime;
    int selectedTextField;
    UIBarButtonItem *doneButton, *cancelButton;
}

@property (strong, nonatomic) IBOutlet UITextField *mallTextField;
@property (strong, nonatomic) IBOutlet UITextField *cinemaTextField;
@property (strong, nonatomic) IBOutlet UITextField *timeTextField;
@property (strong, nonatomic) NSString *movieTitle;


- (void)getAvailableCinemas:(NSInteger) row;
- (void)getAvailableTime:(NSInteger) row;

- (void)pressedDoneButton:(UIBarButtonItem *)sender;
- (void)pressedCancelButton:(UIBarButtonItem *)sender;

@end
