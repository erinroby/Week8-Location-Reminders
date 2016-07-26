//
//  ViewController.m
//  locationReminders
//
//  Created by Erin Roby on 7/25/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "ViewController.h"
@import MapKit;
#import <Parse/Parse.h>
#import "locationController.h"
#import "DetailViewController.h"

@interface ViewController () <MKMapViewDelegate, LocationControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(strong, nonatomic) UIColor *pinTintColor;

- (IBAction)firstLocationButtonPressed:(UIButton *)sender;
- (IBAction)secondLocationButtonPressed:(UIButton *)sender;
- (IBAction)thirdLocationButtonPressed:(UIButton *)sender;
- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView.layer setCornerRadius:20.0];
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    [self setDefaultAnnotations];
    [self getColor];
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        NSLog(@"Succeeded: %i, Error: %@", succeeded, error);
//    }];
   
//    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"]; // you can assign predicates to these.
//    [query findObjectsInBackgroundWithBlock:^(NSArray *_Nullable objects, NSError * _Nullable error) {
//        if (!error) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                NSLog(@"Objects: %@", objects);
//            }];
//        }
//    }];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationmanager]startUpdatingLocation]; // Message - Sender all nested obj-C style.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setDefaultAnnotations {
    NSDictionary *pointOne = @{@"title": @"Pratt Fine Arts Center", @"lat": @47.600157, @"long": @-122.3095426 };
    NSDictionary *pointTwo = @{@"title": @"New York Fashion Academy", @"lat": @47.6654651, @"long": @-122.3845994 };
    NSDictionary *pointThree = @{@"title": @"Zayda Buddy's", @"lat": @47.6668826, @"long": @-122.3849107 };
    NSDictionary *pointFour = @{@"title": @"Olympic Sculpture Park", @"lat": @47.6165162, @"long": @-122.3576973 };
    NSDictionary *pointFive = @{@"title": @"Benaroya Hall", @"lat": @47.6080878, @"long": @-122.339159 };
    
    NSArray *defaultPointers;
    defaultPointers = [NSArray arrayWithObjects: pointOne, pointTwo, pointThree, pointFour, pointFive, nil];
    
    for (id pointer in defaultPointers) {
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        CLLocationCoordinate2D newPointCoordinates = CLLocationCoordinate2DMake([pointer[@"lat"] doubleValue], [pointer[@"long"] doubleValue]);
        newPoint.coordinate = newPointCoordinates;
        newPoint.title = pointer[@"title"];
        [self.mapView addAnnotation:newPoint];
    }
}

-(UIColor *)getColor {
    UIColor *jordyBlue = [UIColor colorWithRed:0.57 green:0.65 blue:1.00 alpha:1.0];
    UIColor *princessPerfume = [UIColor colorWithRed:1.00 green:0.53 blue:0.86 alpha:1.0];
    UIColor *sunny = [UIColor colorWithRed:0.98 green:1.00 blue:0.50 alpha:1.0];
    UIColor *classicRose = [UIColor colorWithRed:0.96 green:0.80 blue:0.91 alpha:1.0];
    UIColor *redOrange = [UIColor colorWithRed:1.00 green:0.32 blue:0.33 alpha:1.0];
    
    NSArray *colors = @[jordyBlue, princessPerfume, sunny, classicRose, redOrange];
    
    UIColor *randomColor = colors[arc4random_uniform(colors.count)];
    NSLog(@"Color: %@", randomColor);
    
    return randomColor;
}

// Code Challenge -->

-(BOOL)isAnagram:(NSString *)stringOne fromStringTwo:(NSString *)stringTwo {
    if (stringOne.length == stringTwo.length) {

        NSMutableArray *stringOneArray = [NSMutableArray array];
        NSMutableArray *stringTwoArray = [NSMutableArray array];
        
        for (int i = 0; i < stringTwo.length; ++i) {
            NSString *letter = [NSString stringWithFormat:@"%c", [stringTwo characterAtIndex:i]];
            [stringTwoArray addObject:letter];
            letter = [NSString stringWithFormat:@"%c", [stringOne characterAtIndex:i]];
            [stringOneArray addObject:letter];
        }
        NSArray *sortedStringOneArray = [stringOneArray sortedArrayUsingSelector:@selector(compare:)];
        NSArray *sortedStringTwoArray = [stringTwoArray sortedArrayUsingSelector:@selector(compare:)];

        NSString *sortedStringOne = [[sortedStringOneArray valueForKey:@"description"] componentsJoinedByString:@""];
        NSString *sortedStringTwo = [[sortedStringTwoArray valueForKey:@"description"] componentsJoinedByString:@""];
        
        if ([sortedStringOne isEqualToString:sortedStringTwo]) {
            return YES;
        }
    }
    return NO;
}

// <-- End Code Challenge.

- (IBAction)firstLocationButtonPressed:(UIButton *)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6796351, -122.3768384);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)secondLocationButtonPressed:(UIButton *)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6375396, -122.576147);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)thirdLocationButtonPressed:(UIButton *)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6130369, -122.3488535);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [sender locationInView:self.mapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        newPoint.coordinate = touchMapCoordinate;
        newPoint.title = @"new location";
        
        [self.mapView addAnnotation:newPoint];
    }
}

- (void)LocationControllerDidUpdateLocation:(CLLocation *)location {
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0) animated:YES];
}

#pragma MARK MapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) { return nil; }
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.pinTintColor = [self getColor];
    
    UIButton *rightCalloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightCalloutButton;
    
    return annotationView;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailViewController"]) {
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *annotationView = (MKAnnotationView *)sender;
            DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
            detailViewController.annotationTitle = annotationView.annotation.title;
            detailViewController.coordinate = annotationView.annotation.coordinate;
        
        }
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"DetailViewController" sender:view];
}

@end
















































