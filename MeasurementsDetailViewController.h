//
//  MeasurementsDetailViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MeasurementsDetailViewController : UIViewController {
    UITextField *lengthTextField;
    UITextField *widthTextField;
    UITextField *heightTextField;
    UITextField *volumeTextField;
    
    id currentResponder;
}

@property (nonatomic, retain) IBOutlet UITextField *lengthTextField;
@property (nonatomic, retain) IBOutlet UITextField *widthTextField;
@property (nonatomic, retain) IBOutlet UITextField *heightTextField;
@property (nonatomic, retain) IBOutlet UITextField *volumeTextField;
@property (nonatomic, assign) id currentResponder;

@end
