//
//  PatientEncounterTableViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "PatientEncounterTableViewController.h"
#import "WoundCareAppDelegate.h"
#import "Patient.h"
#import "FacilityDataObject.h"
#import "EncounterDataModel.h"

@implementation PatientEncounterTableViewController

@synthesize encounterDataObjectModel;


#pragma mark -
#pragma mark View lifecycle

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"called observeValueForKeyPath");
    [self.tableView reloadData];
}

-(void)rightButtonTapped:(id)sender{
    NewPatientEncounterDetailViewController *newEncounter = [[NewPatientEncounterDetailViewController alloc] init];
    newEncounter.title = @"New Encounter";
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:newEncounter];
    [self presentModalViewController:navigation animated:YES];
    [navigation release];
    [newEncounter release];
    return;
}

- (id)init {
    if ((self = [super init])) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonTapped:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        [rightButton release];
        
        WoundCareAppDelegate *app = (WoundCareAppDelegate*)[[UIApplication sharedApplication] delegate];
        patient = app.currentPatient;
        /***
        self.encounterDataObjectModel = [[DataObjectModel alloc] initWithDatabaseName:@"woundcare.sqlite" andInitializingStatement:[NSString stringWithFormat:@"select e.facilityid, f.description as 'facility', e.roomnumber, e.scheduledDate, e.actualDate from encounters e, facilities f where e.patientid = %@ and e.facilityid = f.rowid", patient.patientId]];
        [self.encounterDataObjectModel loadFromDatabaseAsDictionary];
        if([self.encounterDataObjectModel.dataSource count] > 0){
            [patient.encounters removeAllObjects];
            for(NSDictionary *object in self.encounterDataObjectModel.dataSource){
                FacilityDataObject *facility = [[FacilityDataObject alloc] init];
                facility.facilityId = [object objectForKey:@"facilityid"];
                facility.facilityName = [object objectForKey:@"facility"];
                facility.roomNumber = [object objectForKey:@"roomnumber"];
                EncounterDataModel *encounter = [[EncounterDataModel alloc] init];
                encounter.estimatedEncounterDate = [object objectForKey:@"scheduledDate"];
                encounter.actualEncounterDate = [object objectForKey:@"actualDate"];
                encounter.facility = facility;
                [patient.encounters addObject:encounter];
                [facility release];
                [encounter release];
            }
        }
         ***/
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return ([patient.encounters count] > 0) ? [patient.encounters count] : 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    if([patient.encounters count] > 0){
        NSInteger index = ([patient.encounters count] - 1) - indexPath.row;
        EncounterDataModel *encounter = [patient.encounters objectAtIndex:index];
        cell.textLabel.text = encounter.estimatedEncounterDate;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Name: %@ Id:%@", patient.name, patient.patientId];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    } else {
        cell.textLabel.text = @"No encounters found";
    }
    
    return cell;
}

/**
-(void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row % 2){
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:(153/255) alpha:0.75];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
}
**/


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
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
    WoundCareAppDelegate *app = (WoundCareAppDelegate*)[[UIApplication sharedApplication] delegate];
    PatientEncounterDetailViewController *patientDetailController = [[PatientEncounterDetailViewController alloc] init];
    patientDetailController.title = @"Patient Detail";
    patientDetailController.currentEncounter = indexPath.row;
    app.currentEncounter = indexPath.row;
    [self.navigationController pushViewController:patientDetailController animated:YES];
    [patientDetailController release];
}


#pragma mark -
#pragma mark Memory management

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
    [self.encounterDataObjectModel release];
    [super dealloc];
}


@end

