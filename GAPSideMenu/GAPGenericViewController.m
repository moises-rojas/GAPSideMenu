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
@property (weak, nonatomic) IBOutlet UINavigationItem *myNavigationIItem;
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
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)testLog:(id)sender {
    NSLog(@"test a ver si imprime");
    [self.mainViewController openAnotherView];
}

- (IBAction)openLeftMenu:(id)sender {
    [self.mainViewController showLeftPanel];
}

@end
