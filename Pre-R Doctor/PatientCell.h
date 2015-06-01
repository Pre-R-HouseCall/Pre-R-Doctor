//
//  PatientCell.h
//  Pre-R Doctor
//
//  Created by Timothy Acorda on 5/15/15.
//  Copyright (c) 2015 Pre-R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *patientName;
@property (strong, nonatomic) IBOutlet UILabel *patientTag;
@property (strong, nonatomic) IBOutlet UILabel *patientDistance;

@end
