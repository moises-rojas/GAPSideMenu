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


	// Do any additional setup after loading the view.
}


- (void)showLeftPanelOnPortrait {
    CGSize size = self.view.frame.size;
    if (_currentMenuState == CENTER_ON_SCREEN) {
        
        self.leftPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
        [self.view addSubview:self.leftPanelViewController.view];
        _leftPanelViewController.view.frame = CGRectMake(-_leftPanelViewController.view.frame.size.width, 0, _leftPanelViewController.view.frame.size.width, _leftPanelViewController.view.frame.size.height);
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.view.frame = CGRectMake(200, 0, size.width, size.height);
        }];
        _currentMenuState = LEFT_ON_SCREEN;
        
    } else {
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.view.frame = CGRectMake(0, 0, size.width, size.height);
        } completion:^(BOOL finished){
            [self.leftPanelViewController.view removeFromSuperview];
        }];
        
        _currentMenuState = CENTER_ON_SCREEN;
    }
}

- (void)showRightPanelOnPortrait {
    CGSize size = self.view.frame.size;
    if (_currentMenuState == CENTER_ON_SCREEN) {
        
        self.rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
        [self.view addSubview:self.rightPanelViewController.view];
        _rightPanelViewController.view.frame = CGRectMake(320.0, 0, _rightPanelViewController.view.frame.size.width, _rightPanelViewController.view.frame.size.height);
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.view.frame = CGRectMake(-200, 0, size.width, size.height);
            _rightPanelViewController.view.frame = CGRectMake(320, 0, size.width, size.height);
            
        }];
        _currentMenuState = RIGHT_ON_SCREEN;
        
    } else {
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.view.frame = CGRectMake(0, 0, size.width, size.height);
            _rightPanelViewController.view.frame = CGRectMake(320, 0, size.width, size.height);
        }];
        _currentMenuState = CENTER_ON_SCREEN;
    }
}

- (void)showLeftPanelOnLandscape {
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        CGSize size = self.view.frame.size;
        if (_currentMenuState == CENTER_ON_SCREEN) {
            
            self.leftPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
            [self.view addSubview:self.leftPanelViewController.view];
            _leftPanelViewController.view.frame = CGRectMake(-_leftPanelViewController.view.frame.size.width, 0, _leftPanelViewController.view.frame.size.width, _leftPanelViewController.view.frame.size.height);
            
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, -200, size.width, size.height);
            }];
            _currentMenuState = LEFT_ON_SCREEN;
            
        } else {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, 0, size.width, size.height);
            } completion:^(BOOL finished){
                [self.leftPanelViewController.view removeFromSuperview];
                [self.leftPanelViewController removeFromParentViewController];
            }];
            _currentMenuState = CENTER_ON_SCREEN;
        }
    } else {
        CGSize size = self.view.frame.size;
        
        if (_currentMenuState == CENTER_ON_SCREEN) {
            self.leftPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
            [self.view addSubview:self.leftPanelViewController.view];
            _leftPanelViewController.view.frame = CGRectMake(-_leftPanelViewController.view.frame.size.width, 0, _leftPanelViewController.view.frame.size.width, _leftPanelViewController.view.frame.size.height);
            
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, 200, size.width, size.height);
            }];
            _currentMenuState = LEFT_ON_SCREEN;
            
        } else {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, 0, size.width, size.height);
            } completion:^(BOOL finished){
                [self.leftPanelViewController.view removeFromSuperview];

            }];
            _currentMenuState = CENTER_ON_SCREEN;
        }
    }

}
- (void)showRightPanelOnLandscape {
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        CGSize size = self.view.frame.size;
        if (_currentMenuState == CENTER_ON_SCREEN) {
            self.rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
            [self.view addSubview:self.rightPanelViewController.view];
            _rightPanelViewController.view.frame = CGRectMake(self.view.frame.size.height, 0, _rightPanelViewController.view.frame.size.width, _rightPanelViewController.view.frame.size.height);
            
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, 200, size.width, size.height);
            }];
            _currentMenuState = RIGHT_ON_SCREEN;
            
        } else {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, 0, size.width, size.height);
            } completion:^(BOOL finished){
                _rightPanelViewController.view.frame = CGRectMake(self.view.frame.size.height, 0, _rightPanelViewController.view.frame.size.width, _rightPanelViewController.view.frame.size.height);
                [self.rightPanelViewController.view removeFromSuperview];
            }];
            _currentMenuState = CENTER_ON_SCREEN;
        }
    } else {
        CGSize size = self.view.frame.size;
        if (_currentMenuState == CENTER_ON_SCREEN) {
            self.rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
            [self.view addSubview:self.rightPanelViewController.view];
            _rightPanelViewController.view.frame = CGRectMake(self.view.frame.size.height, 0, _rightPanelViewController.view.frame.size.width, _rightPanelViewController.view.frame.size.height);
            
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, -200, size.width, size.height);
            }];
            _currentMenuState = RIGHT_ON_SCREEN;
            
        } else {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, 0, size.width, size.height);
            } completion:^(BOOL finished){
                 _rightPanelViewController.view.frame = CGRectMake(self.view.frame.size.height, 0, _rightPanelViewController.view.frame.size.width, _rightPanelViewController.view.frame.size.height);
                [self.rightPanelViewController.view removeFromSuperview];
            }];
            _currentMenuState = CENTER_ON_SCREEN;
        }
    }
}

- (IBAction)showLeftPanel:(id)sender {
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self showLeftPanelOnPortrait];
        
    } else {
        [self showLeftPanelOnLandscape];
            }
}

- (IBAction)showRightPanel:(id)sender {
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self showRightPanelOnPortrait];
    } else {
        [self showRightPanelOnLandscape];
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
