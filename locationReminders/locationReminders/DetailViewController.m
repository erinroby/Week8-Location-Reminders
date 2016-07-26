//
//  DetailViewController.m
//  locationReminders
//
//  Created by Erin Roby on 7/26/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController()

@end

@implementation DetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"TITLE: %@", self.annotationTitle);
    NSLog(@"LATLONG: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
}

@end
