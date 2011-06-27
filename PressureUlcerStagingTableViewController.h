//
//  PressureUlcerStagingTableViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 9/18/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PressureUlcerStagingTableViewController : UITableViewController {
    NSArray *sections;
    NSArray *stage1options;
    NSArray *stage2options;
    NSArray *stage3options;
    NSArray *stage4options;
    NSArray *allOptions;
    NSArray *unstageableoptions;
}

@property (nonatomic, retain) NSArray *sections;
@property (nonatomic, retain) NSArray *stage1options;
@property (nonatomic, retain) NSArray *stage2options;
@property (nonatomic, retain) NSArray *stage3options;
@property (nonatomic, retain) NSArray *stage4options;
@property (nonatomic, retain) NSArray *unstageableoptions;
@property (nonatomic, retain) NSArray *allOptions;

@end