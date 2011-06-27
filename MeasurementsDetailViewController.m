//
//  MeasurementsDetailViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "MeasurementsDetailViewController.h"


@implementation MeasurementsDetailViewController

@synthesize lengthTextField, widthTextField, heightTextField, volumeTextField, currentResponder;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void)rightButtonTapped:(id)sender{
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.currentResponder = textField;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    switch(textField.tag){
        case 0:
            [self.widthTextField becomeFirstResponder];
            break;
        case 1:
            [self.heightTextField becomeFirstResponder];
            break;
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.currentResponder resignFirstResponder];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightButtonTapped:)];
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


- (void)dealloc {
    [self.lengthTextField release];
    [self.widthTextField release];
    [self.heightTextField release];
    [self.volumeTextField release];
    self.currentResponder = nil;
    [super dealloc];
}


@end
