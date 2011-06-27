//
//  WoundImageViewController.m
//  WoundCare
//
//  Created by nathan bardgett on 9/6/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WoundImageViewController.h"


@implementation WoundImageViewController
@synthesize imageView;

-(void)imagePickerController:(UIImagePickerController *)camera didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}
-(void)rightButtonTapped:(id)sender{
    UIImagePickerController *camera = [[[UIImagePickerController alloc] init] autorelease];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    camera.allowsEditing = YES;
    camera.delegate = self;
    [self presentModalViewController:camera animated:YES];
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(rightButtonTapped:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
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
    [imageView release];
    [super dealloc];
}


@end
