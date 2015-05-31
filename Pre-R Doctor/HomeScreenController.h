//
//  HomeScreenController.h
//  Pre-R Doctor
//
//  Created by Timothy Acorda on 5/15/15.
//  Copyright (c) 2015 Pre-R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScreenController : UIViewController<CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * jsonArray;
@property (nonatomic, strong) NSMutableArray * formArray;
@property NSInteger selectedIndex;
@end
