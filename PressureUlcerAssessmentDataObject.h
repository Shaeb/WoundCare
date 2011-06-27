//
//  PressureUlcerAssessmentDataObject.h
//  WoundCare
//
//  Created by nathan bardgett on 10/14/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PressureUlcerAssessmentDataObject : NSObject {
    NSString *assessmentId;
    NSMutableArray *locations; // a pressure ulcer mught be coccyx + sacrum, etc
    NSMutableArray *stagingAssessmentData;
    NSString *height;
    NSString *width;
    NSString *length;
    NSMutableArray *surroundingAreaAssessmentData;
    NSMutableArray *drainageDescriptions;
    NSMutableArray *interventions;
}

@property(nonatomic, retain) NSString *assessmentId;
@property(nonatomic, retain) NSMutableArray *locations;
@property(nonatomic, retain) NSMutableArray *stagingAssessmentData;
@property(nonatomic, retain) NSString *height;
@property(nonatomic, retain) NSString *width;
@property(nonatomic, retain) NSString *length;
@property(nonatomic, retain) NSMutableArray *surroundingAreaAssessmentData;
@property(nonatomic, retain) NSMutableArray *drainageDescriptions;
@property(nonatomic, retain) NSMutableArray *interventions;

@end
