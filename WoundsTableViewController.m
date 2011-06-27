//
//  WoundsTableViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WoundsTableViewController.h"
#import "WoundTypesTableViewController.h"
#import "WoundCareAppDelegate.h"
#import "EncounterDataModel.h"
#import "FacilityDataObject.h"
#import "WoundsDataObject.h"
#import "Patient.h"

@implementation WoundsTableViewController
@synthesize wounds, selectedWound;

#pragma mark -
#pragma mark View lifecycle

-(void)rightButtonTapped:(id)sender{
    //[self.navigationController pushViewController:[[PressureUlcerAssessmentTableViewController alloc] init] animated:YES];
    //PressureUlcerAssessmentTableViewController *modal = [[PressureUlcerAssessmentTableViewController alloc] init];
    WoundTypesTableViewController *modal = [[WoundTypesTableViewController alloc] init];
    modal.title = @"Add a wound";
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:modal];
    [modal release];
    [self presentModalViewController:navigation animated:YES];
    [navigation release];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonTapped:)];
    
    self.wounds = [[NSMutableArray alloc] init];
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    WoundCareAppDelegate *app = (WoundCareAppDelegate*)[[UIApplication sharedApplication] delegate];
    for(EncounterDataModel *encounter in app.currentPatient.encounters){
        for(WoundsDataObject *wound in encounter.wounds){
            
            //[NSArray arrayWithObjects:wound.woundId, wound.woundType, wound.woundTypeId, wound.woundLocation, wound.woundLocationId, encounter.estimatedEncounterDate, nil]
            
            //[NSArray arrayWithObjects:@"woundId", @"woundType",@"woundTypeId", @"woundLocation", @"woundLocationId", @"assessedDate", nil]
            if(![ids containsObject:wound.woundId]){
                [self.wounds addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:wound.woundId, wound.woundType, wound.woundTypeId, wound.woundLocation, wound.woundLocationId, encounter.estimatedEncounterDate, nil] forKeys:[NSArray arrayWithObjects:@"woundId", @"woundType",@"woundTypeId", @"woundLocation", @"woundLocationId", @"assessedDate", nil]]];
                [ids addObject:wound.woundId];
            }
        }
    }
    [ids release];
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
    return [self.wounds count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSDictionary *dictionary = [self.wounds objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", [dictionary objectForKey:@"woundType"], [dictionary objectForKey:@"woundLocation"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Assessed on %@", [dictionary objectForKey:@"assessedDate"]];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
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
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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
    [self.wounds release];
    [super dealloc];
}


@end

