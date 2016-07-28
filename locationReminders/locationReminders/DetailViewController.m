//
//  DetailViewController.m
//  locationReminders
//
//  Created by Erin Roby on 7/26/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"

@interface DetailViewController()

- (IBAction)createReminderButtonSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *reminderName;
@property (weak, nonatomic) IBOutlet UITextField *meters;

@end

@implementation DetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"TITLE: %@", self.annotationTitle);
    NSLog(@"LATLONG: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TestNotification" object:nil];
}

- (IBAction)createReminderButtonSelected:(id)sender {
    NSString *reminderName = _reminderName.text; // ours will get this from the text fields!
    NSNumber *radius = [NSNumber numberWithFloat:_meters.text.floatValue]; // ours will get this from the text fields!
    
    Reminder *reminder = [Reminder object];
    reminder.name = reminderName;
    reminder.radius = radius;
    
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude]; // this is the same for the homework.
    
    if (self.completion) {
        self.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:radius.floatValue]);
        
        [self.navigationController popViewControllerAnimated:YES]; // as soon as we complete and the completion is called, we dismiss the view controller.
    }
}

@end
