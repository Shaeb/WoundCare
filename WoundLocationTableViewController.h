//
//  WoundLocationTableViewController.h
//  WoundCare
//
//  Created by nathan bardgett on 11/7/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WoundLocationTableViewController : UITableViewController {
    NSMutableArray *dataSource;
}

@property (nonatomic, copy) NSMutableArray *dataSource;

@end