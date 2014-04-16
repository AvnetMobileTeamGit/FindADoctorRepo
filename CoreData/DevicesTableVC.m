//
//  DevicesTableVC.m
//  CoreData
//
//  Created by Sebastian, Justin on 4/10/14.
//  Copyright (c) 2014 Sebastian, Justin. All rights reserved.
//

#import "DevicesTableVC.h"
#import "DoctorTableViewCell.h"
#import "Doctor.h"
#import "FileParser.h"
@interface DevicesTableVC ()

@end

@implementation DevicesTableVC
@synthesize devicesArray;
static NSString* DoctortableIdentifier=@"DoctorListTableIdentifier";

-(NSManagedObjectContext*) managedObjectContext{
    NSManagedObjectContext *context=nil;
    id theAppDelegate =[[UIApplication sharedApplication]delegate];
    if([theAppDelegate performSelector:@selector(managedObjectContext)]){
        context= [theAppDelegate managedObjectContext];
        
    }
    return context;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSManagedObjectContext *managedObject= [self managedObjectContext];
    NSFetchRequest *fetchRequest= [[NSFetchRequest alloc]initWithEntityName:@"Doctor"];
    devicesArray=[[managedObject executeFetchRequest:fetchRequest error:nil]mutableCopy];
    [self.tableView reloadData];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView=(id) [self.view viewWithTag:1];
    tableView.rowHeight=110;
    UINib *nib=[UINib nibWithNibName:@"DoctorTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:DoctortableIdentifier];
    
    NSManagedObjectContext *managedObject= [self managedObjectContext];
    NSFetchRequest *fetchRequest= [[NSFetchRequest alloc]initWithEntityName:@"Doctor"];
    devicesArray=[[managedObject executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    if([devicesArray count]==0){
        [self setupCoreData];
    }
    
}


-(void)setupCoreData
{
    FileParser* parser = [[FileParser alloc] init];
    NSString* csvString = [parser readInFile];
    NSArray* fileString = [parser parseCSVStringIntoArray:csvString];
    NSMutableArray *doctorsList = [parser createDoctorsFromArray:fileString];
    
    for (Doctor *doc in doctorsList) {
        NSManagedObjectContext *context = [self managedObjectContext];
        NSManagedObject *newDoctor = [NSEntityDescription insertNewObjectForEntityForName:@"Doctor" inManagedObjectContext:context];
        
        [newDoctor setValue:doc.firstName forKey:@"firstName"];
        [newDoctor setValue:doc.lastName forKey:@"lastName"];
        [newDoctor setValue:doc.speciality forKey:@"specialty"];
        [newDoctor setValue:doc.address forKey:@"address"];
        [newDoctor setValue:doc.phoneNumber forKey:@"phoneNumber"];
        
        NSError *error=nil;
        if(! [context save:&error]){
            NSLog(@"Can't save, error: %@", [error description]);
        }
        
    }
    NSLog(@"Number of Doctors: %lu", (unsigned long)[doctorsList count]);
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [devicesArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DoctorTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:DoctortableIdentifier forIndexPath:indexPath];
    NSManagedObject *tempDevice= [devicesArray objectAtIndex:indexPath.row];
    cell.firstNameLabel.text=[tempDevice valueForKey:@"firstName" ];
    cell.lastNameLabel.text=[tempDevice valueForKey:@"lastName" ];
    cell.specialtyLabel.text=[tempDevice valueForKey:@"specialty" ];
    cell.addressLabel.text=[tempDevice valueForKey:@"phoneNumber" ];
    
    return cell;

}

@end
