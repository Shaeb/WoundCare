//
//  NewPatientEncounterDetailViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerViewAutomator;

@interface NewPatientEncounterDetailViewController : UIViewController <UITextFieldDelegate> {
    UILabel *patientNameLabel;
    UITextField *dateTextField;
    UITextField *facilityTextField;
    UITextField *roomTextField;
    UIDatePicker *datePicker;
    
    UIPickerView *facilityPickerView;
    PickerViewAutomator *facilityPickerViewAutomator;
    NSInteger selectedFacilitId;
    
    id currentResponder;
}

@property (nonatomic, retain) IBOutlet UILabel *patientLabel;
@property (nonatomic, retain) IBOutlet UITextField *dateTextField;
@property (nonatomic, retain) IBOutlet UITextField *facilityTextField;
@property (nonatomic, retain) IBOutlet UITextField *roomTextField;
@property (nonatomic, assign) NSInteger selectedFacilityId;
@property (nonatomic, retain) id currentResponder;

@end
