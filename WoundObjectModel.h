//
//  WoundObjectModel.h
//  WoundCare
//
//  Created by nathan bardgett on 11/7/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WoundObjectModel : NSObject {
    NSMutableArray *locations;
    NSMutableArray *assessmentData;
    NSMutableArray *drainage;
    NSMutableArray *surroundAreaAssessmentData;
    NSMutableArray *interventions;
    NSInteger length;
    NSInteger width;
    NSInteger height;
}

@property (nonatomic,retain) NSMutableArray *locations;
@property (nonatomic,retain) NSMutableArray *assessmentData;
@property (nonatomic,retain) NSMutableArray *drainage;
@property (nonatomic,retain) NSMutableArray *surroundAreaAssessmentData;
@property (nonatomic,retain) NSMutableArray *interventions;
@property (nonatomic, assign) NSInteger length;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@end
