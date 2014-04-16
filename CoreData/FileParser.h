//
//  FileParser.h
//  DoctorParser
//
//  Created by Bambrick, Josh on 4/15/14.
//  Copyright (c) 2014 Avnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileParser : NSObject
@property NSString* file;


-(NSString *) readInFile;
-(NSMutableArray *)parseCSVStringIntoArray:(NSString *)csvString;
-(NSString *)documentFolderPath ;
-(NSMutableArray *) createDoctorsFromArray:(NSArray *)doctorStringsArray;

@end
