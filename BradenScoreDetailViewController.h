//
//  BradenScoreDetailViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataObjectModel.h"
#import "Serializing.h"

@class PickerViewAutomator;

@interface BradenScoreDetailViewController : UIViewController <UITextFieldDelegate, Serializing> {
    id currentResponder;
    
    DataObjectModel *dataObjectModel;
    
    NSInteger bradenScore;
    
    UITextField *sensoryTextField;
    PickerViewAutomator *sensoryDataModel;
    UIPickerView *sensoryPickerView;
    NSInteger sensoryScore;
    
    UITextField *moistureTextField;
    PickerViewAutomator *moistureDataModel;
    UIPickerView *moisturePickerView;
    NSInteger moistureScore;
    
    UITextField *activityTextField;
    PickerViewAutomator *activityDataModel;
    UIPickerView *activityPickerView;
    NSInteger activityScore;
    
    UITextField *mobilityTextField;
    PickerViewAutomator *mobilityDataModel;
    UIPickerView *mobilityPickerView;
    NSInteger mobilityScore;
    
    UITextField *nutritionTextField;
    PickerViewAutomator *nutritionDataModel;
    UIPickerView *nutritionPickerView;
    NSInteger nutritionScore;
    
    UITextField *frictionAndShearTextField;
    PickerViewAutomator *frictionAndShearDataModel;
    UIPickerView *frictionAndShearPickerView;
    NSInteger frictionAndShearScore;
    
    UITextField *scoreTextField;
    NSInteger totalScore;
}

@property (nonatomic, retain) DataObjectModel *dataObjectModel;
@property (nonatomic, retain) IBOutlet UITextField *sensoryTextField;
@property (nonatomic, retain) IBOutlet UITextField *moistureTextField;
@property (nonatomic, retain) IBOutlet UITextField *activityTextField;
@property (nonatomic, retain) IBOutlet UITextField *mobilityTextField;
@property (nonatomic, retain) IBOutlet UITextField *nutritionTextField;
@property (nonatomic, retain) IBOutlet UITextField *frictionAndShearTextField;
@property (nonatomic, retain) IBOutlet UITextField *scoreTextField;

@property (nonatomic, retain) id currentResponder;
@end
