//
//  PatientListTableViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "PatientListTableViewController.h"
#import "DataObjectModel.h"
#import "Patient.h"
#import "WoundCareAppDelegate.h"

@implementation PatientListTableViewController

@synthesize dataSource, modalNavigationController, newPatientModalViewController;

#pragma mark -
#pragma mark View lifecycle


-(void)rightButtonTapped:(id)sender{
    NewPatientDetailViewController *newPatient = [[NewPatientDetailViewController alloc] init];
    newPatient.title = @"New Patient";
    newPatient.dataObjectModel = self.dataSource;
    //newPatient.myParent = self;
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:newPatient];
    [newPatient release];
    [self presentModalViewController:navigation animated:YES];
    [navigation release];
}

/**
-(void)objectFoundInDatabaseAsString:(NSString *)objectValue{
    Patient *patient = [[Patient alloc] initWithName:objectValue];
    [self.dataSource addObject:patient];
    //NSLog(@"\nfound object: %@ vs. %@", patient.name, objectValue);
    [patient release];
}
 **/

/***
-(void) reloadDataModelFromDatabase:(BOOL)shouldReloadTableView{
    database = [[Database alloc] initWithName:@"woundcare.sqlite"];
    //database.target = self;
    //database.objectFoundAsString = @selector(objectFoundInDatabaseAsString:);
    self.dataSource = [database queryDatabase:(char *)"select name from patients" withError:nil];
    self.viewNeedsToBeReloaded = shouldReloadTableView;
}
 ***/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"\n\nCalled viewDidLoad\n\n");
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonTapped:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
    
    //[self reloadDataModelFromDatabase:NO];
    
    //self.newPatientModalViewController = [[NewPatientDetailViewController alloc] init];
    //newPatientModalViewController.title = @"New Patient";
    //newPatientModalViewController.myParent = self;
    //[self.navigationController pushViewController:newPatient animated:YES];
    //self.modalNavigationController = [[UINavigationController alloc] initWithRootViewController:newPatientModalViewController];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"\n\nCalled viewWillAppear: \n\n");
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear called");
}
*/

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSLog(@"called numberOfSectionInTableView");
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"called numberOfRowsInSection: rows = %d", [dataSource.dataSource count]);
    return ([dataSource.dataSource count] > 0 ) ? [dataSource.dataSource count] : 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"BUILDING CELL");
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...  

    if(0 < [dataSource.dataSource count]){
        WoundCareAppDelegate *app = (WoundCareAppDelegate *)[[UIApplication sharedApplication] delegate];
        Patient *patient = [app.patients objectAtIndex:indexPath.row];
        //    cell.textLabel.text = [dataSource.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = patient.name;
        cell.detailTextLabel.text = patient.patientId;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.text = @"No Patients Found";
        cell.detailTextLabel.text = @"(you can add one by tapping the '+' button.)";
    }

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WoundCareAppDelegate *app = (WoundCareAppDelegate*)[[UIApplication sharedApplication] delegate];
    if( 0 < [app.patients count]){
        //app.currentPatient = [app.patients objectAtIndex:indexPath.row];
        [app selectCurentPatient:indexPath.row];
        //[app.currentPatient loadPatientFromDatabase];
        PatientEncounterTableViewController *patientEncounter = [[PatientEncounterTableViewController alloc] init];
        patientEncounter.title = @"Patient Encounter";
        [self.navigationController pushViewController:patientEncounter animated:YES];
        [patientEncounter release];   
    }
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    //[database release];
    [dataSource release];
    [newPatientModalViewController release];
    [modalNavigationController release];
    [super dealloc];
}


@end

