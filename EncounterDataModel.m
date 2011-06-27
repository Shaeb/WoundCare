//
//  EncounterDataModel.m
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "EncounterDataModel.h"


@implementation EncounterDataModel

@synthesize actualEncounterDate, encounterId, estimatedEncounterDate, facility, wounds;

- (id)init {
    if ((self = [super init])) {
        self.wounds = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    self.encounterId = nil;
    [self.actualEncounterDate release];
    [self.estimatedEncounterDate release];
    [self.facility release];
    [self.wounds release];
    
    [super dealloc];
}
@end
