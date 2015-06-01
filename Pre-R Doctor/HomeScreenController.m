//
//  HomeScreenController.m
//  Pre-R Doctor
//
//  Created by Timothy Acorda on 5/15/15.
//  Copyright (c) 2015 Pre-R. All rights reserved.
// revamped
#import <CoreLocation/CoreLocation.h>
#import "HomeScreenController.h"
#import "Patient.h"
#import "PatientCell.h"
#import "User.h"

#define getDataURL  @"http://54.191.98.90/api/1.0/getPatients/"

@interface HomeScreenController()<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *availControl;
@property (nonatomic) User* user;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl* refreshControl;

@end

@implementation HomeScreenController

-(NSMutableArray *)formArray {
    if(!(_formArray)) {
        _formArray = [[NSMutableArray alloc]init];
    }
    return _formArray;
}

-(NSMutableArray *)jsonArray {
    if(!(_jsonArray)) {
        _jsonArray = [[NSMutableArray alloc]init];
    }
    return _jsonArray;
}

-(User*)user {
    if(!_user) {
        _user = [[User alloc]init];
    }
    return _user;
}

-(void)viewDidLoad {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.distanceFilter = 610;
    self.availControl.selectedSegmentIndex = [defaults objectForKey:@"Availability"];
    
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.tableView;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getConnections) forControlEvents:UIControlEventValueChanged];
    tableViewController.refreshControl = self.refreshControl;
    [self retrieveData];
    
}

- (IBAction)availChanged:(id *)sender {
    NSInteger value = self.availControl.selectedSegmentIndex;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Availability Change" message:@"Are you sure you want to change?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:cancelAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    if(value == 0) {
        //if([CLLocationManager authorizationStatus])
        //if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
         //   [self.locationManager requestWhenInUseAuthorization];
        //}
        [self.locationManager startUpdatingLocation];
    } else if (value == 1) {
        
    } else if (value == 2) {
        
    } else if (value == 3) {

    }
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    //This method will show us that we recieved the new location
    NSLog(@"Latitude = %f",newLocation.coordinate.latitude );
    NSLog(@"Longitude =%f",newLocation.coordinate.longitude);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.formArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PatientCell *PatientCell = [tableView dequeueReusableCellWithIdentifier:@"patientCell"];
    Patient* temppatient = [self.formArray objectAtIndex:indexPath.row];
    NSInteger docLat = self.locationManager.location.coordinate.latitude;
    NSInteger docLong = self.locationManager.location.coordinate.longitude;
    CLLocation * docLoc = [[CLLocation alloc] initWithLatitude:docLat longitude:docLong];
    NSLog([NSString stringWithFormat:@"LAT IS %f and LONG IS %f", temppatient.patLat, temppatient.patLong]);
    CLLocation * patientLoc = [[CLLocation alloc] initWithLatitude:temppatient.patLat.integerValue longitude:temppatient.patLong.integerValue];
    CLLocationDistance meters = [docLoc distanceFromLocation:patientLoc];
    
    if (temppatient) {
        PatientCell.patientName.text  = temppatient.patName;
        PatientCell.patientDistance.text = [NSString stringWithFormat:@"%f miles away", meters * .000621371];
        //PatientCell.patientTag.text = temppatient.patTag;
        //gecode compute latitiude and longitude
        //PatientCell.patientDistance.text = temppatient.patDistance;
    }
    //PatientCell.descriptionLabel.text = temppatient.patDescription;
    //PatientCell.buttonToForm.tag = indexPath.row;
    //[PatientCell.buttonToForm addTarget:self action:@selector(formButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return PatientCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void) retrieveData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *id = [defaults objectForKey:@"ID"];
    NSString *newurl = [NSString stringWithFormat:@"%@%@", getDataURL, id];
    NSLog(newurl);
    NSURL * url = [NSURL URLWithString:newurl];
    NSData * data = [NSData dataWithContentsOfURL:url];
    self.jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.formArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.jsonArray.count ; i++) {
        NSString * uid = [[self.jsonArray objectAtIndex:i] objectForKey:@"UserId"];
        NSString * uName = [[self.jsonArray objectAtIndex:i] objectForKey:@"Name"];
        NSString *  uEmail= [[self.jsonArray objectAtIndex:i] objectForKey:@"Email"];
        NSString * uNumber = [[self.jsonArray objectAtIndex:i] objectForKey:@"Number"];
        NSString * uSymptoms = [[self.jsonArray objectAtIndex:i] objectForKey:@"Symptoms"];
        NSString * uLatitude = [[self.jsonArray objectAtIndex:i] objectForKey:@"Latitude"];
        NSString * uLongitude = [[self.jsonArray objectAtIndex:i] objectForKey:@"Longitude"];
        NSString * uStreetAddress = [[self.jsonArray objectAtIndex:i] objectForKey:@"StreetAddress"];
        NSString * uCity = [[self.jsonArray objectAtIndex:i] objectForKey:@"City"];
        NSString * uState = [[self.jsonArray objectAtIndex:i] objectForKey:@"State"];
        NSString * uZip = [[self.jsonArray objectAtIndex:i] objectForKey:@"Zip"];
        NSString * uDateTime = [[self.jsonArray objectAtIndex:i] objectForKey:@"DateTime"];
        NSString * uTag = [[self.jsonArray objectAtIndex:i] objectForKey:@"Tag"];
        
        if(uLatitude) {
            [self.formArray addObject:[[Patient alloc] init2:uid andEmail:uEmail andName:uName andTag:uTag andPhone:uNumber andDate:uDateTime andState:uState andCity:uCity andStreet:uStreetAddress andZip:uZip]];
            NSLog(@"Entered address init");
            Patient * pat1 = [self.formArray objectAtIndex:0];
            NSLog([NSString stringWithFormat:@"after init %@", pat1.patLong]);
        } else {
            [self.formArray addObject:[[Patient alloc] init1:uid andEmail:uEmail andName:uName andTag:uTag andPhone:uNumber andDate:uDateTime andLat:uLatitude andLong:uLongitude]];
            NSLog(@"Entered latlong init");
         }
    }
//    if (self.refreshControl) {
  //      [self.refreshControl endRefreshing];
  //  }
   [self.tableView reloadData];
}



@end
