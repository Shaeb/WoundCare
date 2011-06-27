//
//  PinCodeViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/7/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "PinCodeViewController.h"


@implementation PinCodeViewController

@synthesize pinCodePickerView, firstNumber, secondNumber, thirdNumber, fourthNumber;

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;   
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}

-(NSString* )pickerView:(UIPickerView *)aPickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%d", row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch(component){
        case 0:
            firstNumber = row;
            break;
        case 1:
            secondNumber = row;
            break;
        case 2:
            thirdNumber = row;
            break;
        case 3:
            fourthNumber = row;
    }
    if( 9 == firstNumber && 7 == secondNumber && 1 == thirdNumber && 0 == fourthNumber ){
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Application successfully ulocked" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil] autorelease];
        [alert show];
    }
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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


- (void)dealloc {
    [pinCodePickerView release];
    [super dealloc];
}


@end
