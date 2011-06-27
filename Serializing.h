//
//  Serializing.h
//  WoundCare
//
//  Created by nathan bardgett on 9/22/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Query;

@protocol Serializing

-(void)queryDidComplete:(Query *)query;
@end
