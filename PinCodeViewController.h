//
//  PinCodeViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/7/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PinCodeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView *pinCodePickerView;
    NSInteger firstNumber;
    NSInteger secondNumber;
    NSInteger thirdNumber;
    NSInteger fourthNumber;
}

@property (nonatomic, retain) IBOutlet UIPickerView *pinCodePickerView;
@property (nonatomic, assign) NSInteger firstNumber;
@property (nonatomic, assign) NSInteger secondNumber;
@property (nonatomic, assign) NSInteger thirdNumber;
@property (nonatomic, assign) NSInteger fourthNumber;

@end
