//
//  Patient.m
//  WoundCare
//
//  Created by nathan bardgett on 9/9/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "Patient.h"
#import "EncounterDataModel.h"
#import "WoundsDataObject.h"
#import "FacilityDataObject.h"
#import "DataObjectModel.h"

@implementation Patient

@synthesize name, patientId, encounters;

-(id)initWithName:(NSString *)aName{
    self = [super init];
    if(self){
        self.name = aName;
        self.encounters = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)loadPatientFromDatabase{
    [self loadEncountersFromDatabase];
    [self loadWoundsFromDatabase];
    NSLog(@"loadPatientFromDatabase # of wounds: %d", [self.encounters count]);
}

-(void)loadEncountersFromDatabase{
    [self.encounters removeAllObjects];
    DataObjectModel *dataObjectModel = [[DataObjectModel alloc] initWithDatabaseName:@"woundcare.sqlite" andInitializingStatement:[NSString stringWithFormat:@"select e.rowid, e.facilityid, f.description as 'facility', e.roomnumber, e.scheduledDate, e.actualDate from encounters e, facilities f where e. patientid = %@ and e.facilityid = f.rowid", self.patientId]];
    [dataObjectModel loadFromDatabaseAsDictionary];
    for(int i = 0; i < [dataObjectModel.dataSource count]; i++){
        NSDictionary *dictionary = [dataObjectModel.dataSource objectAtIndex:i];
        [self.encounters addObject:[[EncounterDataModel alloc] init]];
        EncounterDataModel *encounter = [self.encounters objectAtIndex:i];
        encounter.encounterId = [dictionary objectForKey:@"rowid"];
        encounter.actualEncounterDate = [dictionary objectForKey:@"actualDate"];
        encounter.estimatedEncounterDate = [dictionary objectForKey:@"scheduledDate"];
        encounter.facility = [[FacilityDataObject alloc] init];
        encounter.facility.facilityId = [dictionary objectForKey:@"facilityid"];
        encounter.facility.facilityName = [dictionary objectForKey:@"facility"];
        encounter.facility.roomNumber = [dictionary objectForKey:@"roomnumber"];
    }
}

-(void)loadWoundsFromDatabase{
    for(EncounterDataModel *encounter in self.encounters){
        [encounter.wounds removeAllObjects];
        DataObjectModel *dataObjectModel = [[DataObjectModel alloc] initWithDatabaseName:@"woundcare.sqlite" andInitializingStatement:[NSString stringWithFormat:@"select t.rowid as 'woundTypeId', t.description as 'type', l.rowid as 'woundLocationId', l.description as 'location', w.rowid from wounds w, woundtypes t, woundlocations l where w.woundTypeId = t.rowid and w.woundLocationId = l.rowid and w.patientid = %@",self.patientId]];
        NSLog(@"loadWoundsFromDatabase: %@", dataObjectModel.initializingStatement);
        [dataObjectModel loadFromDatabaseAsDictionary];

        for(int i = 0; i < [dataObjectModel.dataSource count]; i++){
            NSDictionary *dictionary = [dataObjectModel.dataSource objectAtIndex:i];
            [encounter.wounds addObject:[[WoundsDataObject alloc] init]];
            WoundsDataObject *wound = [encounter.wounds objectAtIndex:i];
            wound.woundId = [dictionary objectForKey:@"rowid"];
            wound.woundType = [dictionary objectForKey:@"type"];
            wound.woundTypeId = [dictionary objectForKey:@"woundTypeId"];
            wound.woundLocation = [dictionary objectForKey:@"location"];
            wound.woundLocationId = [dictionary objectForKey:@"woundLocationId"];
            //encounter.estimatedEncounterDate = [dictionary objectForKey:@"scheduledDate"];
            //encounter.actualEncounterDate = [dictionary objectForKey:@"actualDate"];
        }

        [dataObjectModel release];
    }
}

-(void)dealloc{
    [name release];
    [encounters release];
    [self.patientId release];
    [super dealloc];
}
@end
