//
//  BySpecialtyViewController.m
//  IOS Project Try 2
//
//  Created by Dubicki, Jeremy on 4/15/14.
//  Copyright (c) 2014 Avnet. All rights reserved.
//

#import "BySpecialtyViewController.h"
#import "DoctorListView.h"
@interface BySpecialtyViewController ()

@end

@implementation BySpecialtyViewController

@synthesize specialtyTF, withinTF, locationTF, IdPrefixTF;

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
    [self.navigationItem setHidesBackButton:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)find_a_doctor:(id)sender
{    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"I Found A Doctor By Specialty"
                                                    message:[NSString stringWithFormat:@"You have searched for a Doctor with a speciality of %@, for results within %@ from a location of %@ with an ID Prefix of %@",specialtyTF.text, withinTF.text, locationTF.text, IdPrefixTF.text]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



- (IBAction)dismissTheKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"findDoctor"]) {
        SearchObject *search= [[SearchObject alloc]init];
        search.speciality=specialtyTF.text;
        search.idPrefix=IdPrefixTF.text;
        search.withIn=withinTF.text;
        search.location=locationTF.text;
        [[segue destinationViewController] setSearch:search];
    }
}


@end
