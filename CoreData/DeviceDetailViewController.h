//
//  DeviceDetailViewController.h
//  CoreData
//
//  Created by Sebastian, Justin on 4/10/14.
//  Copyright (c) 2014 Sebastian, Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *specialityTF;
- (IBAction)saveBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@end
