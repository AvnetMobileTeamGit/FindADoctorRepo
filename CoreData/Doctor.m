//
//  Doctor.m
//  DoctorParser
//
//  Created by Bambrick, Josh on 4/15/14.
//  Copyright (c) 2014 Avnet. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor
@synthesize firstName, lastName, address, network, idPrefix, providerType, speciality, businessHours, phoneNumber, latitude, longitude;

-(Doctor *) createDoctorFirstName: (NSString *)  _firstName withLastName:(NSString *) _lastName
                      withAddress:(NSString *) _address
                      withNetwork:(NSString *) _network
                       withPrefix:(NSString *) _idPrefix
                 withProviderType:(NSString *) _providerType
                   withSpeciality:(NSString *) _speciality
                withBusinessHours:(NSString *) _businessHours
                  withPhoneNumber:(NSString *) _phoneNumber
                     withLatitude:(NSString *)_latitude
                    withLongitude:(NSString *)_longitude{
    
    firstName = _firstName;
    lastName = _lastName;
    address = _address;
    network = _network;
    idPrefix = _idPrefix;
    providerType = _providerType;
    speciality = _speciality;
    businessHours = _businessHours;
    phoneNumber = _phoneNumber;
    latitude = _latitude;
    longitude = _longitude;
    
    
    return self;
}


-(void) printDoctorInformation{
    
//    NSLog(@"***** Doctor Information *****\n" );
//    NSLog(@"Doctor Name: %@ %@", firstName, lastName);
//    NSLog(@"Hospital Address: %@", address);
//    NSLog(@"Netowork: %@", network);
//    NSLog(@"Prefix: %@", idPrefix);
//    NSLog(@"Provider Type : %@", providerType);
//    NSLog(@"Speciality: %@", speciality);
//    NSLog(@"Business Hours: %@", businessHours);
//    NSLog(@"Phone Number: %@", phoneNumber);
//    NSLog(@"Latitude: %@", latitude);
//    NSLog(@"Longitude: %@", longitude);
//    NSLog(@"\n\n");
}


@end
