//
//  EncounterDataModel.h
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FacilityDataObject.h"

@interface EncounterDataModel : NSObject {
    NSInteger encounterId;
    NSString *actualEncounterDate;
    NSString *estimatedEncounterDate;
    NSMutableArray *wounds;
    FacilityDataObject *facility;
}

@property (nonatomic, assign) NSInteger encounterId;
@property (nonatomic, retain) NSString *actualEncounterDate;
@property (nonatomic, retain) NSString *estimatedEncounterDate;
@property (nonatomic, retain) NSMutableArray *wounds;
@property (nonatomic, retain) FacilityDataObject *facility;

@end
