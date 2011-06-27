//
//  NewPatientDetailViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class FacilityDataModel;
@class PickerViewAutomator;
@class DataObjectModel;

@interface NewPatientDetailViewController : UIViewController <UITextFieldDelegate> {
    UIScrollView *scrollView;
    
    UITextField *patientNameTextField;
    
    UITextField *facilityTextField;
    UIPickerView *facilityPickerView;
    PickerViewAutomator *facilityDataModel;
    
    UITextField *roomTextField;
    
    UITextField *woundTypeTextField;
    UIPickerView *woundTypePickerView;
    PickerViewAutomator *woundTypeDataModel;
    
    UITextField *woundLocationTextField;
    UIPickerView *woundLocationPickerView;
    PickerViewAutomator *woundLocationDataModel;
    
    UITextField *visitDateTextField;
    UIDatePicker *visitDatePicker;
    
    DataObjectModel *dataObjectModel;
    UITableViewController *myParent;
    
    id currentResponder;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *patientNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *facilityTextField;
@property (nonatomic, retain) IBOutlet UITextField *roomTextField;
@property (nonatomic, retain) IBOutlet UITextField *visitDateTextField;
@property (nonatomic, retain) IBOutlet UITextField *woundTypeTextField;
@property (nonatomic, retain) IBOutlet UITextField *woundLocationTextField;
@property (nonatomic, retain) DataObjectModel *dataObjectModel;
@property (nonatomic, retain) UITableViewController *myParent;
@property (nonatomic, retain) id currentResponder;

-(IBAction)didEndOnExit:(id)sender;
@end
