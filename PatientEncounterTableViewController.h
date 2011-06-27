//
//  PatientEncounterTableViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientEncounterDetailViewController.h"
#import "NewPatientEncounterDetailViewController.h"
#import "DataObjectModel.h"
@class Patient;

@interface PatientEncounterTableViewController : UITableViewController {
    Patient *patient;
    DataObjectModel *encounterDataObjectModel;
}

@property (nonatomic, retain) DataObjectModel *encounterDataObjectModel;

@end