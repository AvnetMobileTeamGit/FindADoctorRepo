//
//  DoctorListView.m
//  IOS Project Try 2
//
//  Created by Sebastian, Justin on 4/15/14.
//  Copyright (c) 2014 Avnet. All rights reserved.
//

#import "DoctorListView.h"
#import "DoctorTableViewCell.h"
#import "Doctor.h"
#import "FileParser.h"
#import "BySpecialtyViewController.h"
@interface DoctorListView ()
@property CLLocation *userLocation;
@end

@implementation DoctorListView
@synthesize doctorsList,search, userLocation;

static NSString* DoctortableIdentifier=@"DoctorListTableIdentifier";
UITableView *tableView;
NSArray *sortedKeys;


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
    tableView=(id) [self.view viewWithTag:1];
    tableView.rowHeight=110;
    UINib *nib=[UINib nibWithNibName:@"DoctorTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:DoctortableIdentifier];
    
    NSManagedObjectContext *managedObject= [self managedObjectContext];
    NSFetchRequest *fetchRequest= [[NSFetchRequest alloc]initWithEntityName:@"Doctor"];
    doctorsList=[[managedObject executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    if([doctorsList count]==0){
        [self setupCoreData];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(navigate)];
    
    userLocation=[[CLLocation alloc] initWithLatitude:30.2669544 longitude:-97.7423234];


}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSManagedObjectContext *managedObject= [self managedObjectContext];
    NSFetchRequest *fetchRequest= [[NSFetchRequest alloc]initWithEntityName:@"Doctor"];
    NSString *searchQuery;
    if (search.speciality != nil) {
        searchQuery = [NSString stringWithFormat:@"speciality == '%@' AND idPrefix == '%@' ", search.speciality,search.idPrefix];
    }else{
        if([search.firstName isEqualToString:search.lastName]){
            searchQuery =[NSString stringWithFormat:@"(firstName == '%@' OR lastName =='%@') AND providerType =='%@'", search.firstName, search.lastName, search.providerType];
        }
        else{
            searchQuery =[NSString stringWithFormat:@"(firstName == '%@' AND lastName =='%@') AND providerType =='%@'", search.firstName, search.lastName, search.providerType];
        }
        

    }
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:searchQuery]];

    doctorsList=[[managedObject executeFetchRequest:fetchRequest error:nil]mutableCopy];
   
    [self findNearestLocAndDistance];
    [tableView reloadData];
    
    
}

-(void)findNearestLocAndDistance {
    
    CLLocation *nearestLoc = nil;
    CLLocationDistance nearestDis = DBL_MAX;
    NSMutableDictionary *docDistanceDictionary= [[NSMutableDictionary alloc]init];
    for(NSManagedObject *tempDoc in doctorsList){
        NSInteger latitude= [[tempDoc valueForKey:@"latitude"]integerValue];
        NSInteger longitude= [[tempDoc valueForKey:@"longitude"]integerValue];
        CLLocation *docLocation=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        
        CLLocationDistance distance = [userLocation distanceFromLocation:docLocation];
        [docDistanceDictionary setObject:tempDoc forKey:[NSNumber numberWithDouble:distance]];

    }
    sortedKeys =[[docDistanceDictionary allKeys] sortedArrayUsingSelector: @selector(compare:)];
    NSMutableArray *sortedValues = [NSMutableArray array];
    for (NSString *key in sortedKeys)
        [sortedValues addObject: [docDistanceDictionary objectForKey: key]];
    
    doctorsList=sortedValues;
}

-(void)setupCoreData
{
    FileParser* parser = [[FileParser alloc] init];
    NSString* csvString = [parser readInFile];
    NSArray* fileString = [parser parseCSVStringIntoArray:csvString];
    NSMutableArray *doctorsListFromFile = [parser createDoctorsFromArray:fileString];
    
    for (Doctor *doc in doctorsListFromFile) {
        NSManagedObjectContext *context = [self managedObjectContext];
        NSManagedObject *newDoctor = [NSEntityDescription insertNewObjectForEntityForName:@"Doctor" inManagedObjectContext:context];
        
        [newDoctor setValue:doc.firstName forKey:@"firstName"];
        [newDoctor setValue:doc.lastName forKey:@"lastName"];
        [newDoctor setValue:doc.address forKey:@"address"];
        [newDoctor setValue:doc.network forKey:@"network"];
        [newDoctor setValue:doc.idPrefix forKey:@"idPrefix"];
        [newDoctor setValue:doc.providerType forKey:@"providerType"];
        [newDoctor setValue:doc.speciality forKey:@"speciality"];
        [newDoctor setValue:doc.businessHours forKey:@"businessHours"];
        [newDoctor setValue:doc.phoneNumber forKey:@"phoneNumber"];
        [newDoctor setValue:doc.latitude forKey:@"latitude"];
        [newDoctor setValue:doc.longitude forKey:@"longitude"];
            
        NSError *error=nil;
        if(! [context save:&error]){
            NSLog(@"Can't save, error: %@", [error description]);
        }
        
    }
    NSLog(@"Number of Doctors: %lu", (unsigned long)[doctorsListFromFile count]);
    
}

-(void) setSearchObject:(id)newSearch
{
    if (search != newSearch) {
        search = newSearch;
    }
}

-(NSManagedObjectContext*) managedObjectContext{
    NSManagedObjectContext *context=nil;
    id theAppDelegate =[[UIApplication sharedApplication]delegate];
    if([theAppDelegate performSelector:@selector(managedObjectContext)]){
        context= [theAppDelegate managedObjectContext];
        
    }
    return context;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [doctorsList count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DoctorTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:DoctortableIdentifier forIndexPath:indexPath];
    NSManagedObject *tempDevice= [doctorsList objectAtIndex:indexPath.row];
    cell.firstNameLabel.text=[tempDevice valueForKey:@"firstName" ];
    cell.lastNameLabel.text=[tempDevice valueForKey:@"lastName" ];
    cell.specialtyLabel.text=[tempDevice valueForKey:@"speciality" ];
    cell.addressLabel.text=[tempDevice valueForKey:@"phoneNumber" ];
    //NSLog(@"Distance for %@ is: %@", [tempDevice valueForKey:@"firstName" ],sortedKeys[indexPath.row]);
    
    return cell;
    
}



// Method that will redirect back to the find doc by specialty screen.
- (void) navigate
{    
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i = 0; i < [viewControllers count]; i++) {
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[BySpecialtyViewController class]]) {
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }
    
}

@end
