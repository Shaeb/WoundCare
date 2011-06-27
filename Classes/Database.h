//
//  Database.h
//  Homework Tracker
//
//  Created by nathan bardgett on 8/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface Database : NSObject {
	NSString		*databaseName;
	NSString		*databasePath;
    NSString       *lastInsertedROWID;
	
	NSMutableArray	*objects;
    
    SEL objectFoundAsString;
    id  target;
    
    NSMutableArray *queries;
}

@property (nonatomic, retain) NSString *databaseName;
@property (nonatomic, retain) NSString *databasePath;
@property (nonatomic, retain) NSString *lastInsertedROWID;
@property (nonatomic, retain) NSMutableArray *objects;
@property (nonatomic, assign) SEL objectFoundAsString;
@property (nonatomic, retain) id target;
@property (nonatomic, retain) NSMutableArray *queries;

-(id) initWithName:(NSString *)aName;
-(void) checkAndCreateDatabase;
-(void)executeQuerySet;
-(NSString *)retrieveResultAsString:(sqlite3_stmt *)compiledStatement fromColumn:(NSInteger) column;
-(NSArray *) queryDatabase:(char *)aQuery withError:(NSError **) anError;
-(NSArray *) queryDatabaseAsDictionary:(char *)aQuery withError:(NSError **) anError;
-(BOOL) executeQuery:(char *)aQuery withError:(NSError **) anError;


@end
