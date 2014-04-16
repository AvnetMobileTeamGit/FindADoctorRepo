//
//  DoctorTableViewCell.h
//  CoreData
//
//  Created by Sebastian, Justin on 4/15/14.
//  Copyright (c) 2014 Sebastian, Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
