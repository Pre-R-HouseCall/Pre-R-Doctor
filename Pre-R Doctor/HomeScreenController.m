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



@interface HomeScreenController()<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *availControl;
@property (nonatomic) User* user;
@property (nonatomic, retain) CLLocationManager *locationManager;

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
    
    if (temppatient) {
        PatientCell.patientName.text  = temppatient.patName;
        //gecode compute latitiude and longitude
        //PatientCell.patientDistance.text = temppatient.patDistance;
    }
    PatientCell.descriptionLabel.text = temppatient.patDescription;
    PatientCell.buttonToForm.tag = indexPath.row;
    [PatientCell.buttonToForm addTarget:self action:@selector(formButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return PatientCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*-(void) retrieveData {
    NSURL * url = [NSURL URLWithString:getDataURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    self.jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.doctorArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.jsonArray.count - 1; i++) {
        NSString * dID = [[self.jsonArray objectAtIndex:i] objectForKey:@"DoctorId"];
        NSString * dFirstname = [[self.jsonArray objectAtIndex:i] objectForKey:@"FirstName"];
        NSString * dLastname = [[self.jsonArray objectAtIndex:i] objectForKey:@"LastName"];
        NSString * dUsername = [[self.jsonArray objectAtIndex:i] objectForKey:@"Username"];
        NSString * dAvailable = [[self.jsonArray objectAtIndex:i] objectForKey:@"Availability"];
        NSString * dDistance = [[self.jsonArray objectAtIndex:i] objectForKey:@"Distance"];
        NSString * dDescription = [[self.jsonArray objectAtIndex:i] objectForKey:@"Description"];
        NSString * dImage = [[self.jsonArray objectAtIndex:i] objectForKey:@"ProfileImage"];
        
        [self.doctorArray addObject:[[Doctors alloc] initWithDoctorName: dID andUsername:dUsername andFirstname:dFirstname andLastname:dLastname andAvailablity:dAvailable andDistance:dDistance andImage:dImage andDesc:dDescription]];
        
    }
    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
    }
    [self.tableView reloadData];
}*/



@end
