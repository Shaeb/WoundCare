//
//  PickerViewAutomator.h
//  WoundCare
//
//  Created by nathan bardgett on 9/8/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CellDataObject;

@interface PickerViewAutomator : NSObject <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSMutableArray *dataSource;
    SEL didSelectRowAndComponent;
    id target;
    NSInteger rows;
    NSInteger components;
    NSInteger currentlySelectedRow;
    NSInteger currentlySelectedComponent;
}

@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, assign) SEL didSelectRowAndComponent;
@property (nonatomic, retain) id target;

-(id)initWithTarget:(id)aTarget andAction:(SEL)anAction andDataSource:(NSArray *)aDataSource;
-(CellDataObject*)getSelectedCell;

@end
