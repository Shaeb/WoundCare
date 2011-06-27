//
//  Query.m
//  WoundCare
//
//  Created by nathan bardgett on 9/22/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "Query.h"


@implementation Query

@synthesize delegate, query, result, wasSuccessful;

- (void)dealloc {
    [self.delegate release];
    [self.query release];
    [self.result release];
    self.wasSuccessful = nil;
    [super dealloc];
}

@end
