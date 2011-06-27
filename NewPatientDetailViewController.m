//
//  NewPatientDetailViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "NewPatientDetailViewController.h"
//#import "FacilityDataModel.h"
#import "PickerViewAutomator.h"
#import "DataObjectModel.h"
#import "Patient.h"
#import "WoundCareAppDelegate.h"
#import "InputViewAccessoryController.h"
#import "FacilityDataObject.h"
#import "EncounterDataModel.h"
#import "WoundsDataObject.h"
#import "CellDataObject.h"

@implementation NewPatientDetailViewController

@synthesize scrollView,facilityTextField, visitDateTextField, woundTypeTextField, woundLocationTextField, currentResponder, myParent, patientNameTextField, dataObjectModel, roomTextField;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/**
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // setup textfields with inputViews as appropriate
        visitDatePicker = [[UIDatePicker alloc] init];
        self.visitDateTextField.inputView = visitDatePicker;
    }
    return self;
}
 **/

-(IBAction)didEndOnExit:(id)sender{
    //UITextField *textField = (UITextField *)sender;
    //[textField resignFirstResponder];
    [sender resignFirstResponder];
}

-(BOOL)saveNewPatientData{
    //Database *database = [[Database alloc] initWithName:@"woundcare.sqlite"];
//    NSString *sql = [NSString stringWithFormat:@"insert into patients(name) values('%@')", patientNameTextField.text];
//    BOOL success = [dataObjectModel addRecordToDataModelWithQuery:sql];
    //BOOL success = [database executeQuery:[sql UTF8String] withError:nil];
    //[sql release];
    //[database release];
   
    if([self.patientNameTextField.text length] == 0){
        return NO;
    }
    
    
    Patient *newPatient = [[Patient alloc] initWithName:patientNameTextField.text];
    [newPatient.encounters addObject:[[EncounterDataModel alloc] init]];
    EncounterDataModel *encounter = [newPatient.encounters objectAtIndex:0];
    
    if([self.facilityTextField.text length] != 0){
        encounter.facility = [[FacilityDataObject alloc] init];
        encounter.facility.facilityName = self.facilityTextField.text;
        if([self.roomTextField.text length] != 0){
            encounter.facility.roomNumber = [NSString stringWithString:self.roomTextField.text];
            NSLog(@"ROOMNUMBER: %@", encounter.facility.roomNumber);
        }
        CellDataObject *cell = [facilityDataModel getSelectedCell];
        encounter.facility.facilityId = (cell.row + 1); //sqlite indexes starting from 1
    }
    
    if([self.woundTypeTextField.text length] != 0){
        NSLog(@"found a wound");
        [encounter.wounds addObject:[[WoundsDataObject alloc] init]];
        WoundsDataObject *wound = [encounter.wounds objectAtIndex:0]; // this is the first wound
        wound.woundType = self.woundTypeTextField.text;
        if([self.woundLocationTextField.text length] != 0){
            wound.woundLocation = self.woundLocationTextField.text;
        }
        CellDataObject *cell = [woundTypeDataModel getSelectedCell];
        wound.woundId = [NSString stringWithFormat:@"%d", (cell.row + 1)];
        cell = [woundLocationDataModel getSelectedCell];
        wound.woundLocationId = [NSString stringWithFormat:@"%d", (cell.row + 1)];
    } else {
        NSLog(@"No wound found!");
    }
    
    if([self.visitDateTextField.text length] != 0){
        encounter.estimatedEncounterDate = self.visitDateTextField.text;
    }
    
    WoundCareAppDelegate *app = (WoundCareAppDelegate *)[[UIApplication sharedApplication] delegate];
    [app addPatient:newPatient];
    [newPatient release];
    return YES;
}

-(void)rightButtonTapped:(id)sender{
    if(![self.patientNameTextField.text isEqualToString:@""]){
        if([self saveNewPatientData]){
            //NSLog(@"myParent = %@", self.myParent.title);
            //NSAssert(self.myParent, @"my parent is nil");
            //[self.myParent reloadDataModelFromDatabase:YES];
            //myParent.shouldReloadData = YES;
            //[self.myParent.tableView reloadData];
            NSLog(@"dismissed");
            [self dismissModalViewControllerAnimated:YES];
        }
    }
}

-(void)pickerAutomatorDidSelectRow:(NSInteger)row forSelectedObject:(NSString *)data{
    //NSLog(@"called pickerView: didSelectRow:%d forSelectedObject:%@", row, data);
    //self.facilityTextField.text = data;
    [self.currentResponder setText:data];
}

-(void)datePickerValueChanged:(id)sender{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy HH:mm"];
    self.visitDateTextField.text = [format stringFromDate:datePicker.date];
    [format release];
}

-(void)leftButtonTapped:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    WoundCareAppDelegate *app = (WoundCareAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightButtonTapped:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftButtonTapped:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    [leftButton release];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.visitDateTextField.inputView = datePicker;
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [datePicker release];
    
    facilityDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:app.facilitiesDataObjectModel.dataSource];
    facilityPickerView = [[UIPickerView alloc] init];
    facilityPickerView.delegate = facilityDataModel;
    facilityPickerView.dataSource = facilityDataModel;
    facilityPickerView.showsSelectionIndicator = YES;
    self.facilityTextField.inputView = facilityPickerView;
    
    
    /**
    woundTypeDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:[NSArray arrayWithObjects:@"None",@"Pressure Ulcer",@"Venous Stasis Ulcer", @"Arterial Ulcer", @"Diabetic Ulcer", @"Diabetic Foot", @"Abcess", @"Skin Tear", @"Surgical Site", @"Low Braden Score", nil]];
     **/
    woundTypeDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:app.woundTypeDataObjectModel.dataSource];
    woundTypePickerView = [[UIPickerView alloc] init];
    woundTypePickerView.delegate = woundTypeDataModel;
    woundTypePickerView.dataSource = woundTypeDataModel;
    woundTypePickerView.showsSelectionIndicator = YES;
    self.woundTypeTextField.inputView = woundTypePickerView;
    
    woundLocationDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:app.woundLocationDataObjectModel.dataSource];
    woundLocationPickerView = [[UIPickerView alloc] init];
    woundLocationPickerView.delegate = woundLocationDataModel;
    woundLocationPickerView.dataSource = woundLocationDataModel;
    woundLocationPickerView.showsSelectionIndicator = YES;
    self.woundLocationTextField.inputView = woundLocationPickerView;
    
    InputViewAccessoryController *input = [[InputViewAccessoryController alloc] init];
    self.patientNameTextField.inputAccessoryView = input.view;
    [input release];
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

- (void)dealloc {
    [scrollView release];
    [patientNameTextField release];
    [facilityTextField release];
    [facilityPickerView release];
    [facilityDataModel release];
    [roomTextField release];
    [woundTypeTextField release];
    [woundTypePickerView release];
    [woundTypeDataModel release];
    [woundLocationTextField release];
    [woundLocationPickerView release];
    [woundLocationDataModel release];
    [visitDateTextField release];
    [dataObjectModel release];
    [myParent release];
    [currentResponder release];
    [super dealloc];
}


@end
