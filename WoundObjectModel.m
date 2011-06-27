//
//  WoundObjectModel.m
//  WoundCare
//
//  Created by nathan bardgett on 11/7/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WoundObjectModel.h"


@implementation WoundObjectModel

@synthesize assessmentData, drainage, height, interventions, length, locations, surroundAreaAssessmentData, width;

- (id)init {
    if ((self = [super init])) {
        self.assessmentData = [[NSMutableArray alloc] init];
        self.drainage = [[NSMutableArray alloc] init];
        self.interventions = [[NSMutableArray alloc] init];
        self.locations = [[NSMutableArray alloc] init];
        self.surroundAreaAssessmentData = [[NSMutableArray alloc] init];
        
        self.height = 0;
        self.length = 0;
        self.width = 0;
    }
    return self;
}

- (void)dealloc {
    [self.assessmentData release];
    [self.drainage release];
    [self.interventions release];
    [self.locations release];
    [self.surroundAreaAssessmentData release];
    [super dealloc];
}

@end
