//
//  WoundCareAppDelegate.m
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import "WoundCareAppDelegate.h"
#import "DataObjectModel.h"
#import "EncounterDataModel.h"
#import "FacilityDataObject.h"
#import "WoundsDataObject.h"

@implementation WoundCareAppDelegate


@synthesize currentPatient, patients, window, patientNavigationController, pressureUlcerNavigationController, bradenScoreNavigationController, currentEncounter;
@synthesize woundImageNavigationController, settingsNavigationController, pinCodeNavigationController, alert, dataObjectModel,
bradenScoreDataObjectModel, woundTypeDataObjectModel, facilitiesDataObjectModel, woundLocationDataObjectModel;

-(void)loadPatientListFromDatabase{
    NSLog(@"Loading patients  from database");
    [self.patients removeAllObjects];
    [self.dataObjectModel loadFromDatabaseAsDictionary];
    for(int i = 0; i < [self.dataObjectModel.dataSource count]; i++){
        NSDictionary *dictionary = (NSDictionary *)[self.dataObjectModel.dataSource objectAtIndex:i];
        Patient *patient = [[Patient alloc] initWithName:[dictionary objectForKey:@"name"]];
        patient.patientId = [dictionary objectForKey:@"patientid"];
        NSLog(@"loadPatientListFromDatabase: dictionary: %@", dictionary);
        [self.patients addObject:patient];
        [patient release];
        //[self.patients addObject:[[Patient alloc] initWithName:[self.dataObjectModel.dataSource objectAtIndex:i]]];
    }
}

-(BOOL)addEncounter:(EncounterDataModel*)newEncounter toPatient:(Patient *)patient{
    BOOL success = [database executeQuery:[[NSString stringWithFormat:@"insert into encounters(patientid, facilityid, roomnumber, scheduledDate, actualDate) values(%@,%d,'%@','%@','')", patient.patientId, newEncounter.facility.facilityId, newEncounter.facility.roomNumber, newEncounter.estimatedEncounterDate] UTF8String] withError:nil];
    return success;
}

-(BOOL)addWound:(WoundsDataObject *)newWound toEncounter:(EncounterDataModel *)encounter forPatient:(Patient *)patient{
    BOOL success = [database executeQuery:[[NSString stringWithFormat:@"insert into wounds(patientId, woundTypeId, woundLocationId, documentedDateId) values (%@,%@,%@,%d)",patient.patientId, newWound.woundId, newWound.woundLocationId, encounter.encounterId] UTF8String] withError:nil];
    if(success){
        [self refreshWoundTableView];
    }
    return success;
}

-(void)addPatient:(Patient *)newPatient{
    BOOL  success = [database executeQuery:[[NSString stringWithFormat:@"insert into patients(name) values('%@')", newPatient.name] UTF8String] withError:nil];
    if(success){
        //newPatient.patientId = [database.lastInsertedROWID intValue];
        newPatient.patientId = database.lastInsertedROWID;
        // temporary assumption, the first object is the newest encounter
        EncounterDataModel *encounter = [newPatient.encounters objectAtIndex:0];
        WoundsDataObject *wound = [encounter.wounds objectAtIndex:0];
        
        NSLog(@" encounter = %@", encounter);
        
        //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //[formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
        
        NSLog(@"roomNumber = %@", encounter.facility.roomNumber);
        NSLog(@"estimatedEncounterDate = %@", encounter.estimatedEncounterDate);
        
        //NSLog(@"\n\nattempting to insert:\n\n%@\n\n", insert);
        
        success = [self addEncounter:encounter toPatient:newPatient];
        
        if(success){
            NSLog(@"insert a succesS");
        } else {
            NSLog(@"insert not a success");
        }
        
        //NSLog(@"attempting to insert into wounds: %@", insert);
        success = [self addWound:wound toEncounter:encounter forPatient:newPatient];
        
        if(success){
            NSLog(@"wound insert a succesS");
        } else {
            NSLog(@"wound insert not a success");
        }
        
        // now that everything has completed, lets reload the data
        //[self.currentPatient loadPatientFromDatabase];
        [self loadPatientListFromDatabase];
        [patientListController.tableView reloadData];
    }
}

-(void)selectCurentPatient:(NSInteger)index{
    self.currentPatient = [self.patients objectAtIndex:index];
    [self.currentPatient loadPatientFromDatabase];
    [woundsController.tableView reloadData];
    NSLog(@"refreshing wound tableView");
}

-(void)refreshEncounterTableView{
    [self.currentPatient loadEncountersFromDatabase];
    UITableViewController *tableView = [[patientNavigationController viewControllers] lastObject];
    [tableView.tableView reloadData];
}

-(void)refreshWoundTableView{
    [self.currentPatient loadWoundsFromDatabase];
    [woundsController.tableView reloadData];
    NSLog(@"refreshing wound tableView");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.currentPatient = [[Patient alloc] init];
    self.patients = [[NSMutableArray alloc] init];
    
    database = [[Database alloc] initWithName:@"woundcare.sqlite"];
    
//    [self.dataObjectModel addObserver:self forKeyPath:@"dataSource" options:NSKeyValueChangeNewKey context:nil];
    self.dataObjectModel = [[DataObjectModel alloc] initWithDatabaseName:@"woundcare.sqlite" andInitializingStatement:@"select patientid, name from patients"];
    [self loadPatientListFromDatabase];
    
    self.woundTypeDataObjectModel = [[DataObjectModel alloc] initWithDatabaseName:@"woundcare.sqlite" andInitializingStatement:@"select description from woundtypes"];
    [self.woundTypeDataObjectModel loadFromDatabaseAsCells];
    
    self.woundLocationDataObjectModel = [[DataObjectModel alloc] initWithDatabaseName:@"woundcare.sqlite" andInitializingStatement:@"select description from woundlocations"];
    [self.woundLocationDataObjectModel loadFromDatabaseAsCells];
    
    self.facilitiesDataObjectModel = [[DataObjectModel alloc] initWithDatabaseName:@"woundcare.sqlite" andInitializingStatement:@"select rowid as 'facilityid', description from facilities"];
    [self.facilitiesDataObjectModel loadFromDatabaseAsCells];
    
    //[self addObserver:patientListController forKeyPath:@"patients" options:NSKeyValueChangeNewKey context:nil];
    
    self.bradenScoreDataObjectModel = [[DataObjectModel alloc] initWithDatabaseName:@"woundcare.sqlite" andInitializingStatement:@"select description from bradenScoreOptions order by rowid asc"];
    [self.bradenScoreDataObjectModel loadFromDatabaseAsCells];
    
    patientListController = [[PatientListTableViewController alloc] init];
    patientListController.title = @"Patient List";
    patientListController.dataSource = self.dataObjectModel;
    self.patientNavigationController = [[UINavigationController alloc] initWithRootViewController:patientListController];
    
    woundImageController = [[WoundImageViewController alloc] init];
    woundImageController.title = @"Wound Image";
    self.woundImageNavigationController = [[UINavigationController alloc] initWithRootViewController:woundImageController];
    
    /*
    pressureUlcerDetailController = [[PressureUlcerDetailViewController alloc] init];
    pressureUlcerDetailController.title = @"Staging";
    pressureUlcerDetailController.navigationItem.title = @"Pressure Ulcer Staging";
    self.pressureUlcerNavigationController = [[UINavigationController alloc] initWithRootViewController:pressureUlcerDetailController];
    
    pressureUlcerAssessmentController = [[PressureUlcerAssessmentTableViewController alloc] init];
    pressureUlcerAssessmentController.title = @"Assessment";
    pressureUlcerAssessmentController.navigationItem.title = @"Pressure Ulcer Assessment";
    self.pressureUlcerNavigationController = [[UINavigationController alloc] initWithRootViewController:pressureUlcerAssessmentController];
     */
    
    woundsController = [[WoundsTableViewController alloc] init];
    woundsController.title = @"Assessment";
    woundsController.navigationItem.title = @"Pressure Ulcer Assessment";
    self.pressureUlcerNavigationController = [[UINavigationController alloc] initWithRootViewController:woundsController];
    
    bradenScoreController = [[BradenScoreDetailViewController alloc] init];
    bradenScoreController.title = @"Braden Score";
    bradenScoreController.dataObjectModel = self.bradenScoreDataObjectModel;
    self.bradenScoreNavigationController = [[UINavigationController alloc] initWithRootViewController:bradenScoreController];
    
    settingsController = [[SettingsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    settingsController.title = @"Settings";
    self.settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsController];
    
    pinCodeController = [[PinCodeViewController alloc] init];
    pinCodeController.title = @"PIN";
    pinCodeController.navigationItem.title = @"Enter your PIN Code";
    self.pinCodeNavigationController = [[UINavigationController alloc] initWithRootViewController:pinCodeController];
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:self.patientNavigationController, 
                                        self.woundImageNavigationController, self.pressureUlcerNavigationController, 
                                        self.bradenScoreNavigationController, self.settingsNavigationController, 
                                        self.pinCodeNavigationController, nil];

    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

    // Save data if appropriate.
}


-(void)applicationDidBecomeActive:(UIApplication *)application{
     //self.alert = [[UIAlertView alloc] initWithTitle:@"Awoke" message:@"Time to rise sleepy head!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    //[alert show];
}

-(void)alertViewCancel:(UIAlertView *)anAlert{
    NSLog(@"alert view canceled");
}
- (void)dealloc {
    [window release];
    
    [database release];
    
    [currentPatient release];
    //self.currentPatient = nil;
    [patients release];
    
    [patientNavigationController release];
    [patientListController release];
    
    [woundImageNavigationController release];
    [woundImageController release];
    
    [pressureUlcerNavigationController release];
    //[pressureUlcerAssessmentController release];
    [woundsController release];
    
    [bradenScoreNavigationController release];
    [bradenScoreController release];
    
    [settingsController release];
    [settingsNavigationController release];
    
    [pinCodeController release];
    [pinCodeNavigationController release];
    
    [tabBarController release];
    
    [alert release];
    
    [dataObjectModel release];
    [bradenScoreDataObjectModel release];
    [woundTypeDataObjectModel release];
    [woundLocationDataObjectModel release];
    [facilitiesDataObjectModel release];
    
    [super dealloc];
}

@end

