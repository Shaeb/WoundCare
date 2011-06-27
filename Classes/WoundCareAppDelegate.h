//
//  WoundCareAppDelegate.h
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PatientListTableViewController.h"
#import "PressureUlcerDetailViewController.h"
#import "BradenScoreDetailViewController.h"
#import "WoundImageViewController.h"
#import "SettingsTableViewController.h"
#import "PinCodeViewController.h"
//#import "PressureUlcerAssessmentTableViewController.h"
#import "WoundsTableViewController.h"
#import "Patient.h"
#import "Database.h"
#import "EncounterDataModel.h"
#import "WoundsDataObject.h"

@class DataObjectModel;

@interface WoundCareAppDelegate : NSObject <UIApplicationDelegate> {
    
    Patient *currentPatient;
    NSInteger currentEncounter;
    NSMutableArray *patients;
    Database *database;

    UIWindow *window;
    
    UITabBarController *tabBarController;
    
    // patient list controllers
    UINavigationController *patientNavigationController;
    PatientListTableViewController *patientListController;
    
    // for taking pictures
    UINavigationController *woundImageNavigationController;
    WoundImageViewController *woundImageController;
    
    // for pressure ulcer documentation
    UINavigationController *pressureUlcerNavigationController;
    //PressureUlcerDetailViewController *pressureUlcerDetailController;
    //PressureUlcerAssessmentTableViewController *pressureUlcerAssessmentController;
    WoundsTableViewController *woundsController;
    
    // braden score
    UINavigationController *bradenScoreNavigationController;
    BradenScoreDetailViewController *bradenScoreController;
    
    // settings
    UINavigationController *settingsNavigationController;
    SettingsTableViewController *settingsController;
    
    // pin code controller
    UINavigationController *pinCodeNavigationController;
    PinCodeViewController *pinCodeController;
    
    UIAlertView *alert;
    
    DataObjectModel *dataObjectModel;
    DataObjectModel *bradenScoreDataObjectModel;
    DataObjectModel *woundTypeDataObjectModel;
    DataObjectModel *woundLocationDataObjectModel;
    DataObjectModel *facilitiesDataObjectModel;
}

@property (nonatomic, retain) Patient *currentPatient;
@property (nonatomic, assign) NSInteger currentEncounter;
@property (nonatomic, retain) NSMutableArray *patients;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *patientNavigationController;
@property (nonatomic, retain) UINavigationController *pressureUlcerNavigationController;
@property (nonatomic, retain) UINavigationController *bradenScoreNavigationController;
@property (nonatomic, retain) UINavigationController *woundImageNavigationController;
@property (nonatomic, retain) UINavigationController *settingsNavigationController;
@property (nonatomic, retain) UINavigationController *pinCodeNavigationController;
@property (nonatomic, retain) UIAlertView *alert;
@property (nonatomic, retain) DataObjectModel *dataObjectModel;
@property (nonatomic, retain) DataObjectModel *bradenScoreDataObjectModel;
@property (nonatomic, retain) DataObjectModel *woundTypeDataObjectModel;
@property (nonatomic, retain) DataObjectModel *woundLocationDataObjectModel;
@property (nonatomic, retain) DataObjectModel *facilitiesDataObjectModel;

-(void)addPatient:(Patient *)newPatient;
-(BOOL)addEncounter:(EncounterDataModel*)newEncounter toPatient:(Patient*)patient;
-(BOOL)addWound:(WoundsDataObject*)newWound toEncounter:(EncounterDataModel*)encounter forPatient:(Patient*)patient;
-(void)refreshEncounterTableView;
-(void)refreshWoundTableView;
-(void)selectCurentPatient:(NSInteger)index;

@end

