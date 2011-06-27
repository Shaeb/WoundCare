//
//  PatientListTableViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientEncounterTableViewController.h"
#import "NewPatientDetailViewController.h"

@class DataObjectModel;
@class Patient;

@interface PatientListTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
    DataObjectModel *dataSource;
    UINavigationController *modalNavigationController;
    NewPatientDetailViewController *newPatientModalViewController;
}

@property (nonatomic, retain) DataObjectModel *dataSource;
@property (nonatomic, retain) UINavigationController *modalNavigationController;
@property (nonatomic, retain) NewPatientDetailViewController *newPatientModalViewController;

@end