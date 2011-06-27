//
//  WoundsDataObject.m
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WoundsDataObject.h"


@implementation WoundsDataObject

@synthesize woundId, woundLocation, woundType, woundImage, woundLocationId, woundTypeId;

- (void)dealloc {
    [self.woundId release];
    [self.woundLocationId release];
    [self.woundTypeId release];
    [self.woundLocation release];
    [self.woundType release];
    [self.woundImage release];
    [super dealloc];
}

@end
