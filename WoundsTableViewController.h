//
//  WoundsTableViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WoundsTableViewController : UITableViewController {
    NSInteger *selectedWound;
    NSMutableArray *wounds;
}

@property (nonatomic, retain) NSMutableArray *wounds;
@property (nonatomic, assign) NSInteger *selectedWound;

@end