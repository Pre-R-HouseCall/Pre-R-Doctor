//
//  Patient.m
//  Pre-R Doctor
//
//  Created by Timothy Acorda on 5/15/15.
//  Copyright (c) 2015 Pre-R. All rights reserved.
//

#import "Patient.h"
#import <CoreLocation/CoreLocation.h>
@implementation Patient

-(id) init1: (NSString *) patID andEmail: (NSString *) patEmail andName: (NSString *) patName andTag: (NSString *) patTag andPhone: (NSString *) patPhone andDate: (NSString *) patDateTime andLat: (NSString *) patLat andLong: (NSString *) patLong {
    self = [super init];
    if(self) {
        self.patID = patID;
        self.patEmail = patEmail;
        self.patName = patName;
        self.patTag = patTag;
        self.patPhone = patPhone;
        self.patDateTime = patDateTime;
        self.patLat = patLat;
        self.patLong = patLong;
        
    }
    return self;
}

-(id) init2: (NSString *) patID andEmail: (NSString *) patEmail andName: (NSString *) patName andTag: (NSString *) patTag andPhone: (NSString *) patPhone andDate: (NSString *) patDateTime andState: (NSString *) patState andCity: (NSString *) patCity andStreet: (NSString *) patStreet andZip: (NSString *) patZip {
  
    self = [super init];
    if(self) {
        self.patID = patEmail;
        self.patName = patName;
        self.patTag = patTag;
        self.patPhone = patPhone;
        self.patDateTime = patDateTime;
    }
    
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@", patStreet, patCity, patZip, patState];
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     for (CLPlacemark* aPlacemark in placemarks)
                     {
                         self.patLat = [NSString stringWithFormat:@"%lf" , aPlacemark.location.coordinate.latitude];
                         self.patLong = [NSString stringWithFormat:@"%lf", aPlacemark.location.coordinate.longitude];
                         NSLog([NSString stringWithFormat:@"from geo %f from geo %f", aPlacemark.location.coordinate.latitude, aPlacemark.location.coordinate.longitude]);
                     }
                 }];
     return self;
}


@end
