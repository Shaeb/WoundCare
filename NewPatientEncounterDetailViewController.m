//
//  NewPatientEncounterDetailViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "NewPatientEncounterDetailViewController.h"
#import "WoundCareAppDelegate.h"
#import "Patient.h"
#import "FacilityDataObject.h"
#import "EncounterDataModel.h"
#import "PickerViewAutomator.h"
@implementation NewPatientEncounterDetailViewController

@synthesize patientLabel, dateTextField, currentResponder, facilityTextField, roomTextField, selectedFacilityId;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void)leftButtonTapped:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)rightButtonTapped:(id)sender{
    if([self.dateTextField.text isEqualToString:@""] || [self.facilityTextField.text isEqualToString:@""] || [self.roomTextField.text isEqualToString:@""]){
        // real error stuff goes here
        return;
    }
    WoundCareAppDelegate *app = (WoundCareAppDelegate*)[[UIApplication sharedApplication] delegate];
    EncounterDataModel *encounter = [[EncounterDataModel alloc] init];
    FacilityDataObject *facility = [[FacilityDataObject alloc] init];
    
    facility.facilityId = self.selectedFacilityId;
    facility.facilityName = self.facilityTextField.text;
    facility.roomNumber = self.roomTextField.text;
    
    encounter.facility = facility;
    encounter.estimatedEncounterDate = self.dateTextField.text;
    
    BOOL success = [app addEncounter:encounter toPatient:app.currentPatient];
    
    if(success){
        [app refreshEncounterTableView];
    }
    
    [facility release];
    [encounter release];
    
    if(success){
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void)pickerAutomatorDidSelectRow:(NSInteger)row forSelectedObject:(NSString *)data{
    //NSLog(@"called pickerView: didSelectRow:%d forSelectedObject:%@", row, data);
    //self.facilityTextField.text = data;
    self.selectedFacilityId = row + 1;
    [self.currentResponder setText:data];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightButtonTapped:)];
    
    datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateTextField.inputView = datePicker;
    
    WoundCareAppDelegate *app = (WoundCareAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    facilityPickerViewAutomator = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:app.facilitiesDataObjectModel.dataSource];
    facilityPickerView = [[UIPickerView alloc] init];
    facilityPickerView.delegate = facilityPickerViewAutomator;
    facilityPickerView.dataSource = facilityPickerViewAutomator;
    facilityPickerView.showsSelectionIndicator = YES;
    self.facilityTextField.inputView = facilityPickerView;
    
    self.patientLabel.text = app.currentPatient.name;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.currentResponder = textField;
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [currentResponder resignFirstResponder];
}

-(void)datePickerValueChanged:(id)sender{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy HH:mm"];
    self.dateTextField.text = [format stringFromDate:datePicker.date];
    [format release];
}

- (void)dealloc {
    [patientNameLabel release];
    [datePicker release];
    [dateTextField release];
    [facilityTextField release];
    [facilityPickerView release];
    [facilityPickerViewAutomator release];
    [roomTextField release];
    [currentResponder release];
    [super dealloc];
}


@end
