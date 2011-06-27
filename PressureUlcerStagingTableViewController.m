//
//  PressureUlcerStagingTableViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/18/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "PressureUlcerStagingTableViewController.h"
#import "CellDataObject.h"

@implementation PressureUlcerStagingTableViewController

@synthesize sections, stage1options, stage2options, stage3options, stage4options, unstageableoptions, allOptions;

#pragma mark -
#pragma mark View lifecycle

-(void)rightButtonTapped:(id)sender{
    NSLog(@"will save");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightButtonTapped:)];
    
    self.stage1options = [NSArray arrayWithObjects:[[CellDataObject alloc] initWithData:@"Intact Skin"],
                          [[CellDataObject alloc] initWithData:@"Nonblanchable erythema"],
                          [[CellDataObject alloc] initWithData:@"Skin is warm"],
                          [[CellDataObject alloc] initWithData:@"Skin is cool"],
                          [[CellDataObject alloc] initWithData:@"Skin is edematous"],
                          [[CellDataObject alloc] initWithData:@"Skin is firm"],
                          [[CellDataObject alloc] initWithData:@"Skin is boggy"],
                          [[CellDataObject alloc] initWithData:@"Skin is painful"],
                          [[CellDataObject alloc] initWithData:@"Skin is pruritic"], nil];
    
    self.stage2options = [NSArray arrayWithObjects:[[CellDataObject alloc] initWithData:@"Partial skin loss"],
                          [[CellDataObject alloc] initWithData:@"Superficial ulcer"],
                          [[CellDataObject alloc] initWithData:@"Superficial abrasion"],
                          [[CellDataObject alloc] initWithData:@"Superficial blister"],
                          [[CellDataObject alloc] initWithData:@"Shallow crater"], nil];
    
    self.stage3options = [NSArray arrayWithObjects:[[CellDataObject alloc] initWithData:@"Full thickness skin loss"],
                          [[CellDataObject alloc] initWithData:@"Subcutaneous tissue visible"],
                          [[CellDataObject alloc] initWithData:@"Nectoric Tissue"],
                          [[CellDataObject alloc] initWithData:@"Deep crater"],
                          [[CellDataObject alloc] initWithData:@"Undermining"], nil];
    
    self.stage4options = [NSArray arrayWithObjects:[[CellDataObject alloc] initWithData:@"Extensive desctruction"],
                          [[CellDataObject alloc] initWithData:@"Muscle damage"],
                          [[CellDataObject alloc] initWithData:@"Tendon damage"],
                          [[CellDataObject alloc] initWithData:@"Bone damage"],
                          [[CellDataObject alloc] initWithData:@"Supporting structure damage"],
                          [[CellDataObject alloc] initWithData:@"Tissue necrosis"], nil];
    
    self.unstageableoptions = [NSArray arrayWithObjects:[[CellDataObject alloc] initWithData:@"Due to tissue necrosis"],
                          [[CellDataObject alloc] initWithData:@"Due to eschar"], nil];
    
    self.allOptions = [NSArray arrayWithObjects:self.stage1options, self.stage2options, self.stage3options, self.stage4options, self.unstageableoptions, nil];
    
    self.sections = [NSArray arrayWithObjects:@"Stage I", @"Stage II", @"Stage III", @"Stage IV", @"Unstageable", nil];
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
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self.allOptions objectAtIndex:section] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    //NSString *text = [[self.allOptions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //cell.textLabel.text = [NSString stringWithFormat:@"cell section: %d row:%d", indexPath.section, indexPath.row];
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    CellDataObject *cdo = [[self.allOptions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = cdo.textData;
    cdo.section = indexPath.section;
    cdo.row = indexPath.row;
    if(cdo.isSelected){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sections objectAtIndex:section];
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
    CellDataObject *cdo = [[self.allOptions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cdo.isSelected = YES;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
    [sections release];
    [stage1options release];
    [stage2options release];
    [stage3options release];
    [stage4options release];
    [unstageableoptions release];
    [allOptions release];
    [super dealloc];
}


@end

