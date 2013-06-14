//
//  AppManager.m
//  sureseats
//
//  Created by Martin on 5/27/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager


static AppManager *_instance = nil;
+ (AppManager *)sharedInstance{
    
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc]init];
        });
    }
    return _instance;
}

- (id)init{
    self = [super self];
    if (self) {
        [self loadManagers];
    }
    return self;
}

- (void)loadManagers{
    _dataManager = [[DataManager alloc]init];
}

- (void)unloadManagers{
    _dataManager = nil;
}
@end
