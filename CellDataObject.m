//
//  CellDataObject.m
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "CellDataObject.h"


@implementation CellDataObject

@synthesize textData, section, row, isSelected, ROWID;

-(id)initWithData:(NSString *)data{
    self = [super init];
    if(self){
        self.textData = data;
        self.isSelected = NO;
    }
    return self;
}

-(void)dealloc {
    [self.textData release];
    [self.ROWID release];
    self.section = nil;
    self.row = nil;
    self.isSelected = nil;
    [super dealloc];
}

@end
