//
//  FacilityDataObject.h
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FacilityDataObject : NSObject {
    NSInteger facilityId;
    NSString *facilityName;
    NSString *roomNumber;
}

@property (nonatomic, assign) NSInteger facilityId;
@property (nonatomic, retain) NSString *facilityName;
@property (nonatomic, retain) NSString *roomNumber;

@end
