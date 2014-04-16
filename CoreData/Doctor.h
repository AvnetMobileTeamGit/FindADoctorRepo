//
//  Doctor.h
//  DoctorParser
//
//  Created by Bambrick, Josh on 4/15/14.
//  Copyright (c) 2014 Avnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor : NSObject


@property NSString* firstName;
@property NSString* lastName;
@property NSString* address;
@property NSString* network;
@property NSString* idPrefix;
@property NSString* providerType;
@property NSString* speciality;
@property NSString* businessHours;
@property NSString* phoneNumber;
@property NSString* latitude;
@property NSString* longitude;

-(Doctor *) createDoctorFirstName: (NSString *) _firstName withLastName:(NSString *) _lastName
                      withAddress:(NSString *) _address
                      withNetwork:(NSString *) _network
                       withPrefix:(NSString *) _idPrefix
                 withProviderType:(NSString *) _providerType
                   withSpeciality:(NSString *) _speciality
                withBusinessHours:(NSString *) _businessHours
                  withPhoneNumber:(NSString *) _phoneNumber
                     withLatitude:(NSString *) _latitude
                    withLongitude:(NSString *) _longitude;


-(void) printDoctorInformation;

@end

