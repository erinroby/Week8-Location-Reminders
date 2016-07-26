//
//  locationController.m
//  locationReminders
//
//  Created by Erin Roby on 7/26/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "locationController.h"

@interface LocationController ()<CLLocationManagerDelegate>

@end

@implementation LocationController

+(LocationController *)sharedController {
    static LocationController *sharedController = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[LocationController alloc]init];
    });
    
    return sharedController;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        _locationmanager = [[CLLocationManager alloc]init];
        _locationmanager.delegate = self;
        _locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationmanager.distanceFilter = 100;
    }
    
    [_locationmanager requestAlwaysAuthorization];
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.delegate LocationControllerDidUpdateLocation:locations.lastObject];
    [self setLocation:locations.lastObject];
}

@end
