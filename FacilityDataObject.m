//
//  FacilityDataObject.m
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "FacilityDataObject.h"


@implementation FacilityDataObject

@synthesize facilityId, facilityName, roomNumber;

- (void)dealloc {
    self.facilityId = nil;
    [self.facilityName release];
    [self.roomNumber release];
    [super dealloc];
}
@end
