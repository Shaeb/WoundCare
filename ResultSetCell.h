//
//  ResultSetCell.h
//  WoundCare
//
//  Created by nathan bardgett on 9/8/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    Integer = 0,
    Text,
    Blob,
    Bool
} ResultSetCellFieldType;

@interface ResultSetCell : NSObject {
    NSInteger fieldType;
    id data;
}

@property (nonatomic, retain) id data;

@end
