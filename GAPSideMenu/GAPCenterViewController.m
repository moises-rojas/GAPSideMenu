//
//  GAPCenterViewController.m
//  GAPSideMenu
//
//  Created by Moises Rojas on 12/10/13.
//  Copyright (c) 2013 Moises Rojas. All rights reserved.
//

#import "GAPCenterViewController.h"

@interface GAPCenterViewController ()

@property (nonatomic, assign) SlideMenuState currentMenuState;
@property (nonatomic, weak) UIViewController *leftPanelViewController;
@property (nonatomic, weak) UIViewController *rightPanelViewController;

@end

@implementation GAPCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentMenuState = CENTER_ON_SCREEN;
    self.animationDuration = 1.0;


	// Do any additional setup after loading the view.
}



- (IBAction)showLeftPanel:(id)sender {
    
    CGSize size = self.view.frame.size;
    if (_currentMenuState == CENTER_ON_SCREEN) {
    
        self.leftPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
        [self.view addSubview:self.leftPanelViewController.view];
        //[_leftPanelViewController didMoveToParentViewController:self];
        _leftPanelViewController.view.frame = CGRectMake(-320.0, 0, _leftPanelViewController.view.frame.size.width, _leftPanelViewController.view.frame.size.height);
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.view.frame = CGRectMake(220, 0, size.width, size.height);
            _leftPanelViewController.view.frame = CGRectMake(-300, 0, size.width, size.height);

        }];

        
        _currentMenuState = LEFT_ON_SCREEN;
    
    } else {
        // escondalo
    }
}

- (IBAction)showRightPanel:(id)sender {
    
    if (_currentMenuState == CENTER_ON_SCREEN) {
        self.rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];

    } else {
        // escondalo
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
