//
//  BradenScoreDetailViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "BradenScoreDetailViewController.h"
#import "PickerViewAutomator.h"


@implementation BradenScoreDetailViewController

@synthesize dataObjectModel,currentResponder, sensoryTextField, moistureTextField, activityTextField, mobilityTextField, nutritionTextField, frictionAndShearTextField, scoreTextField;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void)pickerAutomatorDidSelectRow:(NSInteger)row forSelectedObject:(NSString *)data{
    UITextField *textField = (UITextField *)self.currentResponder;
    switch(textField.tag){
        case 0:
            sensoryScore = (row + 1);
            break;
        case 1:
            moistureScore = (row +1);
            break;
        case 2:
            activityScore = (row + 1);
            break;
        case 3:
             mobilityScore = (row + 1);
            break;
        case 4:
            nutritionScore = (row + 1);
            break;
        case 5:
            frictionAndShearScore = (row + 1);
            break;
    }
    totalScore = sensoryScore + mobilityScore + activityScore + moistureScore + nutritionScore + frictionAndShearScore;
    self.scoreTextField.text = [NSString stringWithFormat:@"%d", totalScore];
    [self.currentResponder setText:data];
}

-(void)rightButtonTapped:(id)sender{
    NSLog(@"rightbuttontapped - bradenscore");
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightButtonTapped:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];

    sensoryDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:[self.dataObjectModel.dataSource objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 4)]]];
    sensoryPickerView = [[UIPickerView alloc] init];
    sensoryPickerView.delegate = sensoryDataModel;
    sensoryPickerView.dataSource = sensoryDataModel;
    sensoryPickerView.showsSelectionIndicator = YES;
    self.sensoryTextField.inputView = sensoryPickerView;
    
    moistureDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:[self.dataObjectModel.dataSource objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 4)]]];
    
    moisturePickerView = [[UIPickerView alloc] init];
    moisturePickerView.delegate = moistureDataModel;
    moisturePickerView.dataSource = moistureDataModel;
    moisturePickerView.showsSelectionIndicator = YES;
    self.moistureTextField.inputView = moisturePickerView;
    
    activityDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:[self.dataObjectModel.dataSource objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(8, 4)]]];
    activityPickerView = [[UIPickerView alloc] init];
    activityPickerView.delegate = activityDataModel;
    activityPickerView.dataSource = activityDataModel;
    activityPickerView.showsSelectionIndicator = YES;
    self.activityTextField.inputView = activityPickerView;
    
    mobilityDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:[self.dataObjectModel.dataSource objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(12, 4)]]];
    mobilityPickerView = [[UIPickerView alloc] init];
    mobilityPickerView.delegate = mobilityDataModel;
    mobilityPickerView.dataSource = mobilityDataModel;
    mobilityPickerView.showsSelectionIndicator = YES;
    self.mobilityTextField.inputView = mobilityPickerView;
    
    nutritionDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:[self.dataObjectModel.dataSource objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(16, 4)]]];
    nutritionPickerView = [[UIPickerView alloc] init];
    nutritionPickerView.delegate = nutritionDataModel;
    nutritionPickerView.dataSource = nutritionDataModel;
    nutritionPickerView.showsSelectionIndicator = YES;
    self.nutritionTextField.inputView = nutritionPickerView;
    
    frictionAndShearDataModel = [[PickerViewAutomator alloc] initWithTarget:self andAction:@selector(pickerAutomatorDidSelectRow:forSelectedObject:) andDataSource:[self.dataObjectModel.dataSource objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(20, 3)]]];
    frictionAndShearPickerView = [[UIPickerView alloc] init];
    frictionAndShearPickerView.delegate = frictionAndShearDataModel;
    frictionAndShearPickerView.dataSource = frictionAndShearDataModel;
    frictionAndShearPickerView.showsSelectionIndicator = YES;
    self.frictionAndShearTextField.inputView = frictionAndShearPickerView;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.currentResponder resignFirstResponder];
    //[super touchesBegan:touches withEvent:event];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)aTextField {
    self.currentResponder = aTextField;
    return YES;
}

- (void)dealloc {
    [self.dataObjectModel release];
    
    [self.sensoryTextField release];
    [sensoryDataModel release];
    [sensoryPickerView release];
    
    [self.moistureTextField release];
    [moistureDataModel release];
    [moisturePickerView release];
    
    [self.activityTextField release];
    [activityDataModel release];
    [activityPickerView release];
    
    [self.mobilityTextField release];
    [mobilityDataModel release];
    [mobilityPickerView release];
    
    [self.nutritionTextField release];
    [nutritionDataModel release];
    [nutritionPickerView release];
    
    [self.frictionAndShearTextField release];
    [frictionAndShearDataModel release];
    [frictionAndShearPickerView release];
    
    [self.scoreTextField release];
    [currentResponder release];
    [super dealloc];
}


@end
