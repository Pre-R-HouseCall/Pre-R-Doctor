//
//  Patient.h
//  Pre-R Doctor
//
//  Created by Timothy Acorda on 5/15/15.
//  Copyright (c) 2015 Pre-R. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Patient : NSObject

@property (strong, nonatomic) NSString * patID;
@property (strong, nonatomic) NSString * patTag;
@property (strong, nonatomic) NSString * patName;
@property (strong, nonatomic) NSString * patEmail;
@property (strong, nonatomic) NSString * patDescription;
@property (strong, nonatomic) NSString * patPhone;
@property (strong, nonatomic) NSString * patLat;
@property (strong, nonatomic) NSString * patLong;
@property (strong, nonatomic) NSString * patStreet;
@property (strong, nonatomic) NSString * patCity;
@property (strong, nonatomic) NSString * patState;
@property (strong, nonatomic) NSString * patZip;
@property (strong, nonatomic) NSString * patDateTime;
-(id) init1: (NSString *) patID andEmail: (NSString *) patEmail andName: (NSString *) patName andTag: (NSString *) patTag andPhone: (NSString *) patPhone andDate: (NSString *) patDateTime andLat: (NSString *) patLat andLong: (NSString *) patLong;

-(id) init2: (NSString *) patID andEmail: (NSString *) patEmail andName: (NSString *) patName andTag: (NSString *) patTag andPhone: (NSString *) patPhone andDate: (NSString *) patDateTime andState: (NSString *) patState andCity: (NSString *) patCity andStreet: (NSString *) patStreet andZip: (NSString *) patZip;

//reverseGeocoding
//variables from destination to destination (CLLocationcoordinate2D)
//[patientLocation distanceFromLocation: doctorLocation]
//

@end
