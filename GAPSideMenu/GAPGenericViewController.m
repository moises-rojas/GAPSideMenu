//
//  GAPGenericViewController.m
//  GAPSideMenu
//
//  Created by Moises Rojas on 12/19/13.
//  Copyright (c) 2013 Moises Rojas. All rights reserved.
//

#import "GAPGenericViewController.h"
#import "UIViewController+GAPMainViewController.h"

@interface GAPGenericViewController ()

@end

@implementation GAPGenericViewController

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
- (IBAction)doTheMagic:(id)sender {
    [self.mainViewController showLeftPanel];
}

@end
