//
//  AppManager.h
//  sureseats
//
//  Created by Martin on 5/27/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "DataManager.h"

@interface AppManager : NSObject

@property (nonatomic, strong) DataManager *dataManager;
+ (AppManager *)sharedInstance;
- (void)loadManagers;
- (void)unloadManagers;
@end
