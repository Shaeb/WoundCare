//
//  PatientEncounterDetailViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "PatientEncounterDetailViewController.h"
#import "WoundCareAppDelegate.h"
#import "Patient.h"
#import "EncounterDataModel.h"
#import "FacilityDataObject.h"
#import "WoundsDataObject.h"

@implementation PatientEncounterDetailViewController

@synthesize facilityLabel, patientNameLabel, roomNumberLabel, woundLocationLabel, woundTypeLabel, visitDateLabel, currentEncounter;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void)rightButtonTapped:(id)sender {
}

-(void)showEmailModal{
}

- (id)init {
    if ((self = [super init])) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(rightButtonTapped:)];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    WoundCareAppDelegate *app = (WoundCareAppDelegate*)[[UIApplication sharedApplication] delegate];
    EncounterDataModel *encounter = [app.currentPatient.encounters objectAtIndex:self.currentEncounter];
    self.patientNameLabel.text = app.currentPatient.name;
    self.facilityLabel.text = encounter.facility.facilityName;
    self.roomNumberLabel.text = encounter.facility.roomNumber;
    self.visitDateLabel.text = encounter.estimatedEncounterDate;
    // so far, only show initial wound consulted on
    if(0 < [encounter.wounds count]){
        WoundsDataObject *wound = [encounter.wounds objectAtIndex:0];
        self.woundLocationLabel.text = wound.woundLocation;
        self.woundTypeLabel.text = wound.woundType;
        
    } else {
        self.woundLocationLabel.hidden = YES;
        self.woundTypeLabel.hidden = YES;
    }
    
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


- (void)dealloc {
    self.currentEncounter = nil;
    [self.facilityLabel release];
    [self.patientNameLabel release];
    [self.roomNumberLabel release];
    [self.visitDateLabel release];
    [self.woundLocationLabel release];
    [self.woundTypeLabel release];
    [super dealloc];
}


@end
