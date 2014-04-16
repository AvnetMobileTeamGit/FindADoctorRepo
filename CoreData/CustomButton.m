//
//  CustomButton.m
//  CustomButton
//
//  Created by Dubicki, Jeremy on 4/14/14.
//  Copyright (c) 2014 Avnet. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)specialityBtn:(id)sender
{
    
}



- (IBAction)nameBtn:(id)sender
{
    
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor colorWithRed:0.114 green:0.114 blue:1 alpha:1];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, self.bounds);
}


@end
