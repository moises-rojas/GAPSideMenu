//
//  GAPCenterViewController.m
//  GAPSideMenu
//
//  Created by Moises Rojas on 12/10/13.
//  Copyright (c) 2013 Moises Rojas. All rights reserved.
//

#import "GAPCenterViewController.h"
#import "GAPRightViewController.h"

@interface GAPCenterViewController ()

@property (nonatomic, assign) SlideMenuState currentMenuState;
@property (nonatomic, retain) UIViewController *leftPanelViewController;
@property (nonatomic, retain) GAPRightViewController *rightPanelViewController;
@property (nonatomic) CGSize size;

@end

@implementation GAPCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentMenuState = CENTER_ON_SCREEN;
    self.animationDuration = 1.0;
    self.size = self.view.frame.size;

	// Do any additional setup after loading the view.
}

- (IBAction)showLeftPanel:(id)sender {
    
    if (_currentMenuState == CENTER_ON_SCREEN) {
        self.leftPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
        [self.view addSubview:self.leftPanelViewController.view];
        self.leftPanelViewController.view.tag = 3;
        self.leftPanelViewController.view.frame = CGRectMake(-self.leftPanelViewController.view.frame.size.width, 0, self.leftPanelViewController.view.frame.size.width, self.leftPanelViewController.view.frame.size.height);
        
        switch (self.interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft: {
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(0, -200, self.size.width, self.size.height);
                }];
            }
                break;
            case UIInterfaceOrientationLandscapeRight: {
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(0, 200, self.size.width, self.size.height);
                }];
            }
                break;
            case UIInterfaceOrientationPortrait: {
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(200, 0, self.size.width, self.size.height);
                }];
            }
                break;
            default:
                break;
        }
        _currentMenuState = LEFT_ON_SCREEN;
    } else {
        [self hideSideMenuWithTag:3];
    }

}

- (IBAction)showRightPanel:(id)sender {
    if (_currentMenuState == CENTER_ON_SCREEN) {
        self.rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
        [self.view addSubview:_rightPanelViewController.view];
        self.rightPanelViewController.view.tag = 4;
        self.rightPanelViewController.view.frame = CGRectMake(self.view.frame.size.height, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        switch (self.interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft:{
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(0, 200, self.size.width, self.size.height);
                }];
            }
                break;
            case UIInterfaceOrientationLandscapeRight: {
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(0, -200, self.size.width, self.size.height);
                }];
            }
                break;
            case UIInterfaceOrientationPortrait: {
                self.rightPanelViewController.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(-200, 0, self.size.width, self.size.height);
                }];
            }
                break;
            default:
                break;
        }
        _currentMenuState = RIGHT_ON_SCREEN;
    } else {
        [self hideSideMenuWithTag:4];
    }
}

-(void)hideSideMenuWithTag:(int)tag {
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.view.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    } completion:^(BOOL finished){
        [self removeSuperviewWithTag:tag];
    }];
    _currentMenuState = CENTER_ON_SCREEN;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    _currentMenuState = CENTER_ON_SCREEN;
    /*if (_currentMenuState != CENTER_ON_SCREEN) {
        _currentMenuState = CENTER_ON_SCREEN;
        if (fromInterfaceOrientation == UIInterfaceOrientationPortrait) {
            if (_currentMenuState == LEFT_ON_SCREEN) {
                [self showLeftPanelOnLandscape];
            } else {
                [self showRightPanelOnLandscape];
            }
        } else {
            if (_currentMenuState == RIGHT_ON_SCREEN) {
                [self showRightPanelOnPortrait];
            } else {
                [self showLeftPanelOnPortrait];
            }
        }
    }*/
}

-(void)removeSuperviewWithTag:(int)tag {
    for (UIView *view in [self.view subviews] ) {
        if (view.tag == tag ) {
            [view removeFromSuperview];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
