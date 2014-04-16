//
//  FileParser.m
//  DoctorParser
//
//  Created by Bambrick, Josh on 4/15/14.
//  Copyright (c) 2014 Avnet. All rights reserved.
//

#import "FileParser.h"
#import "Doctor.h"

@implementation FileParser
@synthesize file;


-(NSString *) readInFile {
    //File path
    NSString *filePath = [[self documentFolderPath] stringByAppendingPathComponent:@"doctorsList.csv"];
    
    NSLog(@"File Path: %@", filePath);
    NSError *error;
    
    NSString *csvString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
    {
        NSLog(@"Error reading file: %@", error.localizedDescription);
    }
    
    return csvString;
}

-(NSString *)documentFolderPath {
    //Get the file path location for the app
    NSArray * pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * documentsDirector = [pathsArray objectAtIndex:0];
    
    return documentsDirector  ;
    
}


- (NSMutableArray *)parseCSVStringIntoArray:(NSString *)csvString {
    
    NSMutableArray *csvDataArray = [[NSMutableArray alloc] init];
    
    // break string into an array of individual characters
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[csvString length]];
    int csvStringLength = [csvString length];
    for (int c=0; c < csvStringLength; c++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [csvString characterAtIndex:c]];
        [characters addObject:ichar];
    }
    
    BOOL quotationMarksPresent = true;
    
    for (NSString *ichar in characters) {
        if ([ichar isEqualToString:@"\""]) {
            quotationMarksPresent = TRUE;
            break;
        }
    }
    
    if (!quotationMarksPresent) {
        // quotation marks are NOT present
        // simply break by comma and return
        
        NSArray *componentArray = [csvString componentsSeparatedByString:@","];
        csvDataArray = [NSMutableArray arrayWithArray:componentArray];
        
        return csvDataArray;
        
    } else {
        // quotation marks ARE present
        
        NSString *field = [NSString string];
        BOOL ignoreCommas = FALSE;
        int counter = 0;
        
        for (NSString *ichar in characters) {
            
            if ([ichar isEqualToString:@"\n"]) {
                // end of line reached
                [csvDataArray addObject:field];
                
                return csvDataArray;
            }
            
            if (counter == ([characters count]-1)) {
                // end of character stream reached
                // add last character to field, add to array and return
                field = [field stringByAppendingString:ichar];
                [csvDataArray addObject:field];
                
                return csvDataArray;
            }
            
            
            if (ignoreCommas == FALSE) {
                if ( [ichar isEqualToString:@","] == FALSE) {
                    // ichar is NOT a comma
                    
                    if ([ichar isEqualToString:@"\""] == FALSE) {
                        // ichar is NOT a double-quote
                        field = [field stringByAppendingString:ichar];
                    } else {
                        // ichar IS a double-quote
                        ignoreCommas = TRUE;
                        field = [field stringByAppendingString:ichar];
                    }
                    
                } else {
                    // comma reached - add field to array
                    if ([field isEqualToString:@""] == FALSE) {
                        [csvDataArray addObject:field];
                        field = @"";
                    }
                    
                }
                
            } else {
                
                if ([ichar isEqualToString:@"\""] == FALSE) {
                    // ichar is NOT a double-quote
                    field = [field stringByAppendingString:ichar];
                } else {
                    // ichar IS a double-quote
                    // closing double-quote reached
                    ignoreCommas = FALSE;
                    field = [field stringByAppendingString:ichar];
                    // end of field reached - add field to array
                    if ([field isEqualToString:@""] == FALSE) {
                        [csvDataArray addObject:field];
                        field = @"";
                    }
                    
                }
                
            } // END if (ignoreCommas == FALSE)
            
            counter++;
        } // END for (NSString *ichar in characters)
        
    }
    
    return nil;
}

-(NSMutableArray *) createDoctorsFromArray:(NSArray *)doctorStringsArray {
    //Create an array for the doctors to be stored in.
    NSMutableArray *doctorsList = [[NSMutableArray alloc] init];
    //There are
    int numberOfDoctorElements = 11;
    
    //iterate through the array of string to form a doctor object
    for (int i = 0; i < doctorStringsArray.count; i += numberOfDoctorElements)
    {
        //i:    first name
        NSString* firstName =doctorStringsArray[i];
       
        //i +1: last name
        NSString* lastName = doctorStringsArray[i+1];
        
        //i +2: address - removing qoutes from string
        NSString* address = doctorStringsArray[i+2];
        
        //i +3: network
        NSString* network =doctorStringsArray[i+3];

        //i +4: id prefix
        NSString* prefix =doctorStringsArray[i+4];
       
        //i +5: provider type
        NSString* providerType =doctorStringsArray[i+5];
        
        //i +6: speciality
        NSString* speciality =doctorStringsArray[i+6];
        
        //i +7: business hours - removing quotes from string
        NSString* businessHours =doctorStringsArray[i+7];
        
        //i +8 doctors phone number
        NSString* phoneNumber = doctorStringsArray[i+8];
        
        //i +9 latitude
        NSString* latitude = doctorStringsArray[i +9];
        
        //i +10 longitude
        NSString* longitidue = doctorStringsArray[i +10];
        
        //the CSV file contains " " around entries that have commas in them
        //removing the " " from the following strings
        firstName = [firstName stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        address = [address stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        businessHours =[businessHours stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        //Creating a doctor
        Doctor* newDoctor = [[Doctor alloc] createDoctorFirstName:firstName
                                                     withLastName:lastName
                                                      withAddress:address
                                                      withNetwork:network
                                                       withPrefix:prefix
                                                 withProviderType:providerType
                                                   withSpeciality:speciality
                                                withBusinessHours:businessHours
                                                  withPhoneNumber:phoneNumber
                                                     withLatitude:latitude
                                                    withLongitude:longitidue];
        
        //Printing doctor information for testing
        [newDoctor printDoctorInformation];
        
        // Put doctor into the the array
        [doctorsList addObject:newDoctor];
    }
    return doctorsList;
    
}





@end
