//
//  Database.m
//  Homework Tracker
//
//  Created by nathan bardgett on 8/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Database.h"
#import "ResultSetCell.h"
#import "Query.h"
#import "Serializing.h"

@implementation Database

@synthesize databaseName, databasePath, objects, objectFoundAsString, target, queries, lastInsertedROWID;

-(id) initWithName:(NSString *)aName {
	self = [super init];
	if (self) {
        self.databaseName = aName;
		
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [documentsPath lastObject];
		self.databasePath = [documentsDirectory stringByAppendingPathComponent:self.databaseName];
        
        [fileManager release];
        
        [self checkAndCreateDatabase];
	}
	return self;
}

-(void) checkAndCreateDatabase {
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	success = [fileManager fileExistsAtPath:self.databasePath];
	if (success) {
		//[fileManager release];
        fileManager = nil;
		return;
	}
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
	[fileManager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:nil];
    
	
	//[fileManager release];
    fileManager = nil;
}

-(void)executeQuerySet{
    if(0 == [self.queries count]){
        return;
    }
    for(Query *query in self.queries){
        if(nil != query.delegate){
            if(nil != query.query){
                query.result = [self queryDatabase:[query.query UTF8String] anError:nil];
                if([[query.delegate class] conformsToProtocol:@protocol(Serializing)]){
                    [query.delegate queryDidComplete:query];
                }
            }
        }
    }
}

-(NSString *)retrieveResultAsString:(sqlite3_stmt *)compiledStatement fromColumn:(NSInteger) column{
    NSString *dataObject;
    switch (sqlite3_column_type(compiledStatement, column)) {
        case SQLITE_INTEGER:                            
            dataObject = [NSString stringWithFormat:@"%ld", sqlite3_column_int(compiledStatement, column)];
            //[columnData addObject:[NSString initWithFormat:@"%qi", sqlite3_column_int(compiledStatement, i)]];
            break;
        case SQLITE3_TEXT:
            dataObject = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, column)];
            //[columnData addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i)]];
            break;
            
        default:
            break;
    }
    return dataObject;
}

// this function's primary job is to query the db and get us out all the info into a collection
// for v1 of this function, we will assume that we are pulling out only 1 row
// but will still loop through all the rows
// we will actally just stuff each column into a row, then change that row into an array
-(NSArray *) queryDatabase:(char *)aQuery withError:(NSError **) anError{
	sqlite3 *database;
	NSMutableArray *columnData = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *row = [[NSMutableArray alloc] init];
	
	if (sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
        NSLog(@"opened database @%@",self.databaseName);
		sqlite3_stmt *compiledStatement;
		
		if (sqlite3_prepare_v2(database, aQuery, -1, &compiledStatement, NULL) == SQLITE_OK) {
            NSString *dataObject = nil;
            NSLog(@"statement prepared, will query");
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSLog(@"taking a step");
				int numberOfColumns = sqlite3_column_count(compiledStatement);
                if(1 == numberOfColumns ){
                    [columnData addObject:[self retrieveResultAsString:compiledStatement fromColumn:0]];
                } else {
                    for (int i = 0; i < numberOfColumns; i++) {
                        dataObject = [self retrieveResultAsString:compiledStatement fromColumn:i];
                        if(nil != objectFoundAsString && nil != self.target){
                            if([self.target respondsToSelector:objectFoundAsString]){
                                [self.target performSelector:objectFoundAsString withObject:dataObject];
                            }
                        } else {
                            [row addObject:dataObject];
                        }
                    }
                    [columnData addObject:[row copy]];
                    [row removeAllObjects];
                }
            }
		} else {
			NSLog(@"(queryDatabase:withError) prepare statement failed %s", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(compiledStatement);
	} else {
		NSLog(@"(queryDatabase:withError) could not open database %@", self.databaseName);
	}
	NSLog(@"will return");
	sqlite3_close(database);
    [row release];
	return [NSArray arrayWithArray:columnData];
}

-(NSArray *) queryDatabaseAsDictionary:(char *)aQuery withError:(NSError **) anError{
	sqlite3 *database;
	NSMutableArray *columnData = [[NSMutableArray alloc] init];
    NSMutableArray *resultData = [[NSMutableArray alloc] init];
    NSMutableArray *results = [[NSMutableArray alloc] init];
	
	if (sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
        NSLog(@"opened database @%@",self.databaseName);
		sqlite3_stmt *compiledStatement;
		
		if (sqlite3_prepare_v2(database, aQuery, -1, &compiledStatement, NULL) == SQLITE_OK) {
            NSString *dataObject = nil;
            NSLog(@"statement prepared, will query: %@", [NSString stringWithCString:aQuery]);
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSLog(@"taking a step");
				int numberOfColumns = sqlite3_column_count(compiledStatement);
                for(int i = 0; i < numberOfColumns; i++){
                    [columnData addObject:[NSString stringWithCString:sqlite3_column_name(compiledStatement, i)]];
                    
                    NSString *datum = [self retrieveResultAsString:compiledStatement fromColumn:i];
                    [resultData addObject:datum];
                }
                [results addObject:[NSDictionary dictionaryWithObjects:resultData forKeys:columnData]];
                [columnData removeAllObjects];
                [resultData removeAllObjects];
            }
		} else {
			NSLog(@"(queryDatabase:withError) prepare statement failed %s", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(compiledStatement);
	} else {
		NSLog(@"(queryDatabase:withError) could not open database %@", self.databaseName);
	}
	NSLog(@"will return");
	sqlite3_close(database);
    [columnData release];
    [resultData release];
	return results;
}

-(BOOL) executeQuery:(char *)aQuery withError:(NSError **) anError{
	sqlite3 *database;
    BOOL success = NO;
	
	if (sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
        NSLog(@"opened database @%@",self.databaseName);
		sqlite3_stmt *compiledStatement;
		if (sqlite3_prepare_v2(database, aQuery, -1, &compiledStatement, NULL) == SQLITE_OK) {
            if(sqlite3_step(compiledStatement) == SQLITE_DONE){
                success = YES;
            } else {
                success = NO;
            }
		} else {
            success = NO;
			NSLog(@"(queryDatabase:withError) prepare statement failed %s", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(compiledStatement);
	} else {
		NSLog(@"(queryDatabase:withError) could not open database %@", self.databaseName);
	}
	
	sqlite3_close(database);
    
    if(success){
        NSArray *array = [self queryDatabase:[@"select rowid from patients order by rowid desc limit 1" UTF8String] withError:nil];
        self.lastInsertedROWID = [array objectAtIndex:0];
        //self.lastInsertedROWID = [NSString stringWithFormat:@"%qu", sqlite3_last_insert_rowid(database)];
        NSLog(@"rowid = %@", self.lastInsertedROWID);
    }
    
	return success;
}

-(void) dealloc {
	[databaseName release];
	[databasePath release];
    [lastInsertedROWID release];
	[objects release];
    [target release];
    [queries release];
    objectFoundAsString = nil;
	[super dealloc];
}
@end
