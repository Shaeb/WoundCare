//
//  DataObjectModel.m
//  WoundCare
//
//  Created by nathan bardgett on 9/17/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "DataObjectModel.h"
#import "Database.h"
#import "CellDataObject.h"

@implementation DataObjectModel

@synthesize database, dataSource, initializingStatement;

-(id)initWithDatabaseName:(NSString *)name andInitializingStatement:(NSString *)statement{
    self = [super init];
    if(self){
        self.database = [[Database alloc] initWithName:name];
        self.dataSource = [[NSMutableArray alloc] init];
        self.initializingStatement = statement;
    }
    return self;
}

-(void)loadFromDatabase{
    self.dataSource = [self.database queryDatabase:[self.initializingStatement UTF8String] withError:nil];
    
    NSLog( @"loadFromDatabase: count:%d", [self.dataSource count]);
}

-(void)loadFromDatabaseAsDictionary{
    NSLog( @"loadFromDatabaseAsDictionary:");
    self.dataSource = [self.database queryDatabaseAsDictionary:[self.initializingStatement UTF8String] withError:nil];
    NSLog( @"loadFromDatabase: count:%d", [self.dataSource count]);
}

// in order for this to work, query must be like this:
// select rowid, data
// _or_ select data
-(void)loadFromDatabaseAsCells{
    NSMutableArray *data = (NSMutableArray*)[self.database queryDatabase:[self.initializingStatement UTF8String] withError:nil];
    for(int i = 0; i < [data count]; i++){
        if([[data objectAtIndex:i] isKindOfClass:[NSArray class]]){
            CellDataObject *cell = [[CellDataObject alloc] initWithData:[[data objectAtIndex:i] objectAtIndex:1]];
            cell.ROWID = [[data objectAtIndex:i] objectAtIndex:0];
            [self.dataSource addObject:cell];
            [cell release];
        } else {
            CellDataObject *cell = [[CellDataObject alloc] initWithData:[data objectAtIndex:i]];
            [self.dataSource addObject:cell];
            [cell release];
        }
    }
}

-(BOOL)addRecordToDataModelWithQuery:(NSString *)query{
    NSLog(@"addRecordToDataModelWithQuery: called");
    BOOL success = [database executeQuery:[query UTF8String] withError:nil];
    if(success){
        NSLog(@"addRecordToDataModelWithQuery: success = true");
        [self loadFromDatabase];
    } else {
        NSLog(@"addRecordToDataModelWithQuery: success = false");
    }
    return success;
}

-(void)dealloc {
    [self.database release];
    [self.dataSource release];
    [self.initializingStatement release];
    [super dealloc];
}
@end
