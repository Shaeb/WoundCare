//
//  DataObjectModel.h
//  WoundCare
//
//  Created by nathan bardgett on 9/17/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CellDataObject;
@class Database;

@interface DataObjectModel : NSObject {
    Database *database;
    NSMutableArray *dataSource;
    NSString *initializingStatement;
    
}

@property (nonatomic, retain) Database *database;
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, retain) NSString *initializingStatement;

-(id)initWithDatabaseName:(NSString *)name andInitializingStatement:(NSString *)statement;
-(void)loadFromDatabase;
-(void)loadFromDatabaseAsDictionary;
-(void)loadFromDatabaseAsCells;
-(BOOL)addRecordToDataModelWithQuery:(NSString *)query;

@end
