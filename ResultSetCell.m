//
//  ResultSetCell.m
//  WoundCare
//
//  Created by nathan bardgett on 9/8/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "ResultSetCell.h"


@implementation ResultSetCell

@synthesize data;

-(void)dealloc{
    [self.data release];
    [super dealloc];
}
@end
