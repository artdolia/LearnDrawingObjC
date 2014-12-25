//
//  ADViewController.m
//  L24_drawing
//
//  Created by A D on 1/13/14.
//  Copyright (c) 2014 AD. All rights reserved.
//

#import "ADViewController.h"
#import "ADDrawingView.h"

@interface ADViewController ()

@end

@implementation ADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}



#pragma mark - Rotation -

/*
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    [self.drawingView setNeedsDisplay];
}*/

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [self.drawingView setNeedsDisplay];
}

@end
