//
//  WoundsDataObject.h
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WoundsDataObject : NSObject {
    NSString *woundId;
    NSString *woundType;
    NSString *woundTypeId;
    NSString *woundLocation;
    NSString *woundLocationId;
    UIImage *woundImage;
}

@property (nonatomic, retain) NSString *woundId;
@property (nonatomic, retain) NSString *woundLocationId;
@property (nonatomic, retain) NSString *woundType;
@property (nonatomic, retain) NSString *woundTypeId;
@property (nonatomic, retain) NSString *woundLocation;
@property (nonatomic, retain) UIImage *woundImage;

@end
