//
//  PatientCell.h
//  Pre-R Doctor
//
//  Created by Timothy Acorda on 5/15/15.
//  Copyright (c) 2015 Pre-R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *buttonToForm;
@property (weak, nonatomic) IBOutlet UILabel *patientName;
@property (weak, nonatomic) IBOutlet UILabel *patientDistance;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *tag;
@end
