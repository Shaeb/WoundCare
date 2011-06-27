//
//  Patient.h
//  WoundCare
//
//  Created by nathan bardgett on 9/9/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Patient : NSObject {
    NSString *name;
    NSString *patientId;
    NSMutableArray *encounters;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *patientId;
@property (nonatomic, retain) NSMutableArray *encounters;

-(id)initWithName:(NSString *)aName;
-(void)loadPatientFromDatabase;
-(void)loadEncountersFromDatabase;
-(void)loadWoundsFromDatabase;

@end
