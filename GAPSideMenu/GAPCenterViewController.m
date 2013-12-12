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
    _leftPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    if (_currentMenuState == CENTER_ON_SCREEN) {
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
            [_leftPanelViewController.view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
        }];
        
        _currentMenuState = CENTER_ON_SCREEN;
    }
}

- (void)showRightPanelOnPortrait {
    CGSize size = self.view.frame.size;
    
    self.rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    self.rightPanelViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *verticalConstraint = @"V:[loadingView(==88@1000)]|";
    NSMutableDictionary *viewsDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.rightPanelViewController.view, @"loadingView", nil];


    if (_currentMenuState == CENTER_ON_SCREEN) {
        [self.view addSubview:self.rightPanelViewController.view];
        self.rightPanelViewController.view.tag= 42;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraint
                                                                          options:NSLayoutFormatAlignAllCenterX
                                                                          metrics:nil
                                                                            views:viewsDict]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[loadingView(>=320@1000)]|"
                                                                          options:NSLayoutFormatAlignAllCenterY
                                                                          metrics:nil
                                                                            views:viewsDict]];
        /*[self.view addSubview:x];
        x.frame = CGRectMake(x.frame.size.width, 0, x.frame.size.width, x.frame.size.height);
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.view.frame = CGRectMake(-200, 0, size.width, size.height);
        }];*/
        _currentMenuState = RIGHT_ON_SCREEN;
        
    } else {
        NSLog(@"%d", [self.view.subviews count]);
        for (UIView *view in [self.view subviews] ) {
            if (view.tag == 42 ) {
                [view removeFromSuperview];
            }
        }
        NSLog(@"%d", [self.view.subviews count]);
        
        //[self.view.subviews[3] removeFromSuperview];
        /*[UIView animateWithDuration:self.animationDuration animations:^{
            self.view.frame = CGRectMake(0, 0, size.width, size.height);
        } completion:^(BOOL finished){
            [x removeFromSuperview];
        }];*/
        _currentMenuState = CENTER_ON_SCREEN;
    }
}

- (void)showLeftPanelOnLandscape {
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        CGSize size = self.view.frame.size;
        self.leftPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
        if (_currentMenuState == CENTER_ON_SCREEN) {
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
                [_leftPanelViewController.view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
            }];
            _currentMenuState = CENTER_ON_SCREEN;
        }
    } else {
        CGSize size = self.view.frame.size;
        _leftPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
        if (_currentMenuState == CENTER_ON_SCREEN) {
            [self.view addSubview:_leftPanelViewController.view];
            _leftPanelViewController.view.frame = CGRectMake(-_leftPanelViewController.view.frame.size.width, 0, _leftPanelViewController.view.frame.size.width, _leftPanelViewController.view.frame.size.height);
            
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, 200, size.width, size.height);
            }];
            _currentMenuState = LEFT_ON_SCREEN;
            
        } else {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, 0, size.width, size.height);
            } completion:^(BOOL finished){
                [_leftPanelViewController.view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
            }];
            _currentMenuState = CENTER_ON_SCREEN;
        }
    }

}
- (void)showRightPanelOnLandscape {
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        CGSize size = self.view.frame.size;
        _rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
        if (_currentMenuState == CENTER_ON_SCREEN) {
            [self.view addSubview:_rightPanelViewController.view];
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
                [_rightPanelViewController.view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
            }];
            _currentMenuState = CENTER_ON_SCREEN;
        }
    } else {
        CGSize size = self.view.frame.size;
        self.rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
        if (_currentMenuState == CENTER_ON_SCREEN) {
            [self.view addSubview:_rightPanelViewController.view];
            _rightPanelViewController.view.frame = CGRectMake(self.view.frame.size.height, 0, _rightPanelViewController.view.frame.size.width, _rightPanelViewController.view.frame.size.height);
            
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, -200, size.width, size.height);
            }];
            _currentMenuState = RIGHT_ON_SCREEN;
            
        } else {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.view.frame = CGRectMake(0, 0, size.width, size.height);
            } completion:^(BOOL finished){
                [_rightPanelViewController.view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
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
