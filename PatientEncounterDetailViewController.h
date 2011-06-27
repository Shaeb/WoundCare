//
//  PatientEncounterDetailViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PatientEncounterDetailViewController : UIViewController {
    UILabel *patientNameLabel;
    UILabel *roomNumberLabel;
    UILabel *facilityLabel;
    UILabel *woundTypeLabel;
    UILabel *woundLocationLabel;
    UILabel *visitDateLabel;
    NSInteger currentEncounter;
}

@property (nonatomic, retain) IBOutlet UILabel *patientNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *roomNumberLabel;
@property (nonatomic, retain) IBOutlet UILabel *facilityLabel;
@property (nonatomic, retain) IBOutlet UILabel *woundTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel *woundLocationLabel;
@property (nonatomic, retain) IBOutlet UILabel *visitDateLabel;
@property (nonatomic, assign) NSInteger currentEncounter;

@end
