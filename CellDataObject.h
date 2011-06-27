//
//  CellDataObject.h
//  WoundCare
//
//  Created by nathan bardgett on 9/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CellDataObject : NSObject {
    NSString *textData;
    NSInteger section;
    NSInteger row;
    NSString *ROWID;
    BOOL isSelected;
}

@property (nonatomic, retain) NSString *textData;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, retain) NSString *ROWID;
@property (nonatomic, assign) BOOL isSelected;

-(id)initWithData:(NSString *)data;

@end
