//
//  GAPLeftMenuViewController.m
//  GAPSideMenu
//
//  Created by Moises Rojas on 30/12/13.
//  Copyright (c) 2013 Moises Rojas. All rights reserved.
//

#import "GAPLeftMenuViewController.h"
#import "UIViewController+GAPMainViewController.h"

@interface GAPLeftMenuViewController ()
@end

@implementation GAPLeftMenuViewController

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
    NSLog(@"test");
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (IBAction)test:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                    message:@"You must be connected to the internet to use this app."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)displayLeft:(id)sender {
    NSLog(@"Entró por acá");
    [self.mainViewController openAnotherView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
