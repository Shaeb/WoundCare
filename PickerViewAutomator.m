//
//  PickerViewAutomator.m
//  WoundCare
//
//  Created by nathan bardgett on 9/8/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "PickerViewAutomator.h"
#import "CellDataObject.h"

@implementation PickerViewAutomator

@synthesize dataSource, didSelectRowAndComponent, target;

-(id)initWithTarget:(id)aTarget andAction:(SEL)anAction andDataSource:(NSArray *)aDataSource{
    self = [super init];
    if(self){
        
        if([[aDataSource objectAtIndex:0] isKindOfClass:[NSArray class]]){
            components = [[aDataSource objectAtIndex:0] count];
        } else {
            components = 1;
        }
        self.dataSource = aDataSource;
        
        rows = [self.dataSource count];
        self.target = aTarget;
        self.didSelectRowAndComponent = anAction;
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return components;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return rows;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    CellDataObject *cell;
    if(1 < components){
        cell = [[self.dataSource objectAtIndex:row] objectAtIndex:component] ;
    } else {
        cell = [self.dataSource objectAtIndex:row];
    }
    return cell.textData;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    // first set selected to false
    for(int i = 0; i < [self.dataSource count]; i++){
        for(int k = 0; k < components; k++){
            CellDataObject *cell;
            if(1 < components){
                cell = [[self.dataSource objectAtIndex:i] objectAtIndex:k] ;
            } else {
                cell = [self.dataSource objectAtIndex:i];
            }
            cell.isSelected = NO;
        }
    }
    
    CellDataObject *cell;
    if(1 < components){
        cell = [[self.dataSource objectAtIndex:row] objectAtIndex:component] ;
    } else {
        cell = [self.dataSource objectAtIndex:row];
    }
    cell.isSelected = YES;
    currentlySelectedRow = row;
    currentlySelectedComponent = component;
    cell.row = currentlySelectedRow;
    cell.section = currentlySelectedComponent;
    [target performSelector:didSelectRowAndComponent withObject:row withObject:cell.textData];
}

-(CellDataObject*)getSelectedCell{
    CellDataObject *cell;
    if(1 < components){
        cell = [[self.dataSource objectAtIndex:currentlySelectedRow] objectAtIndex:currentlySelectedComponent] ;
    } else {
        cell = [self.dataSource objectAtIndex:currentlySelectedRow];
    }
    return cell;
}

-(void)dealloc{
    [dataSource release];
    [target release];
    didSelectRowAndComponent = nil;
    rows = nil;
    components = nil;
    currentlySelectedRow = nil;
    currentlySelectedComponent = nil;
    [super dealloc];
}

@end
