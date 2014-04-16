//
//  ByNameViewController.m
//  IOS Project Try 2
//
//  Created by Dubicki, Jeremy on 4/15/14.
//  Copyright (c) 2014 Avnet. All rights reserved.
//

#import "ByNameViewController.h"
#import "DoctorListView.h"

@interface ByNameViewController ()

@end

@implementation ByNameViewController

@synthesize nameTF, providerTypeTF, withinTF, locationTF;

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



- (IBAction)find_a_doctorBtn:(id)sender
{
    
    [locationTF resignFirstResponder];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"I Found A Doctor By Name"
                                                    message:[NSString stringWithFormat:@"You have searched for a Doctor named %@, with a provider type of %@, from a location of %@ and for results within %@",nameTF.text, providerTypeTF.text, locationTF.text, withinTF.text]
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
        NSArray *array=[nameTF.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if([array count]==1){
            search.firstName=nameTF.text;
            search.lastName= nameTF.text;
        }
        else if ([array count]==2){
            search.firstName=array[0];
            search.lastName=array[1];
        }
        else{
            // TODO: Alert message
        }
        search.providerType=providerTypeTF.text;
        search.withIn=withinTF.text;
        search.location=locationTF.text;
        [[segue destinationViewController] setSearch:search];
    }

}


@end
