//
//  PressureUlcerAssessmentDataObject.m
//  WoundCare
//
//  Created by nathan bardgett on 10/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "PressureUlcerAssessmentDataObject.h"


@implementation PressureUlcerAssessmentDataObject

@synthesize assessmentId,drainageDescriptions,height,interventions,length,locations,stagingAssessmentData,surroundingAreaAssessmentData,width;

- (id)init {
    if ((self = [super init])) {
        self.drainageDescriptions = [[NSMutableArray alloc] init];
        self.interventions = [[NSMutableArray alloc] init];
        self.locations = [[NSMutableArray alloc] init];
        self.stagingAssessmentData = [[NSMutableArray alloc] init];
        self.surroundingAreaAssessmentData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [self.assessmentId release];
    [self.drainageDescriptions release];
    [self.height release];
    [self.interventions release];
    [self.length release];
    [self.locations release];
    [self.stagingAssessmentData release];
    [self.surroundingAreaAssessmentData release];
    [self.width release];
    [super dealloc];
}

@end
