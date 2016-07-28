//
//  Reminder.m
//  locationReminders
//
//  Created by Erin Roby on 7/27/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic name;
@dynamic location;
@dynamic radius; // difference between dynamic and sythnesize. getters and setters up the heirarchy here.

+(void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName { // private methods not defined publically in the header.
    return @"Reminder";
}



@end
