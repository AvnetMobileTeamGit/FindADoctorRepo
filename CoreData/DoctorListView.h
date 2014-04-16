//
//  DoctorListView.h
//  IOS Project Try 2
//
//  Created by Sebastian, Justin on 4/15/14.
//  Copyright (c) 2014 Avnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchObject.h"
#import <MapKit/MapKit.h>
@interface DoctorListView : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *doctorsList;
@property (nonatomic, strong) SearchObject *search;
-(void) setSearchObject:(id)newSearch;
@end
