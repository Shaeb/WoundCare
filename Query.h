//
//  Query.h
//  WoundCare
//
//  Created by nathan bardgett on 9/22/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Query : NSObject {
    NSString *query;
    id result;
    BOOL wasSuccessful;
    id delegate;
}

@property (nonatomic, retain) NSString *query;
@property (nonatomic, retain) id result;
@property (nonatomic, assign) BOOL wasSuccessful;
@property (nonatomic, retain) id delegate;

@end
