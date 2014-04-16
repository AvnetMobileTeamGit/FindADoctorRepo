//
//  DeviceDetailViewController.m
//  CoreData
//
//  Created by Sebastian, Justin on 4/10/14.
//  Copyright (c) 2014 Sebastian, Justin. All rights reserved.
//

#import "DeviceDetailViewController.h"

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

-(NSManagedObjectContext*) managedObjectContext{
    NSManagedObjectContext *context=nil;
    id theAppDelegate =[[UIApplication sharedApplication]delegate];
    if([theAppDelegate performSelector:@selector(managedObjectContext)]){
        context= [theAppDelegate managedObjectContext];
        
    }
    return context;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize firstName, lastName, specialityTF, addressTF;
- (IBAction)saveBtn:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newDoctor = [NSEntityDescription insertNewObjectForEntityForName:@"Doctor" inManagedObjectContext:context];
    
    [newDoctor setValue:firstName.text forKey:@"firstName"];
    [newDoctor setValue:lastName.text forKey:@"lastName"];
    [newDoctor setValue:specialityTF.text forKey:@"specialty"];
    [newDoctor setValue:addressTF.text forKey:@"address"];

    NSError *error=nil;
    if(! [context save:&error]){
        NSLog(@"Can't save, error: %@", [error description]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];


}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
