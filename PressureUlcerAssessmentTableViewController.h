//
//  PressureUlcerAssessmentTableViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/18/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PressureUlcerStagingTableViewController.h"

@interface PressureUlcerAssessmentTableViewController : UITableViewController {
    NSArray *dataSource;
}

@property (nonatomic, retain) NSArray *dataSource;

@end