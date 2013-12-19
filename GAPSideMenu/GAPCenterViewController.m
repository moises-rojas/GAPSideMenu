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
@property (nonatomic, retain) UIViewController *leftPanelViewController;
@property (nonatomic, retain) UIViewController *rightPanelViewController;
@property (nonatomic, retain) UIViewController *centerViewController;
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
        self.animationDuration = 1.0;
        self.leftOffset = 200;
        self.rightOffset = 200;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentMenuState = CENTER_ON_SCREEN;
    self.size = self.view.frame.size;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [self.view addGestureRecognizer:panRecognizer];
    
    [self instantiateCenterViewControllerWithTag:3];

	// Do any additional setup after loading the view.
}

- (IBAction)showLeftPanel:(id)sender {
    if (_currentMenuState == CENTER_ON_SCREEN) {
        [self instantiateLeftViewControllerWithTag:1];
        switch (self.interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft: {
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(0, -self.leftOffset, self.size.width, self.size.height);
                }];
            }
                break;
            case UIInterfaceOrientationLandscapeRight: {
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(0, self.leftOffset, self.size.width, self.size.height);
                }];
            }
                break;
            case UIInterfaceOrientationPortrait: {
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(self.leftOffset, 0, self.size.width, self.size.height);
                }];
            }
                break;
            default:
                break;
        }
        _currentMenuState = LEFT_ON_SCREEN;
    } else {
        [self hideSideMenuWithTag:1];
    }
}

- (IBAction)showRightPanel:(id)sender {
    if (_currentMenuState == CENTER_ON_SCREEN) {
        [self instantiateRightViewControllerWithTag:2];
        switch (self.interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft:{
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(0, self.rightOffset, self.size.width, self.size.height);
                }];
            }
                break;
            case UIInterfaceOrientationLandscapeRight: {
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(0, -self.rightOffset, self.size.width, self.size.height);
                }];
            }
                break;
            case UIInterfaceOrientationPortrait: {
                self.rightPanelViewController.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
                [UIView animateWithDuration:self.animationDuration animations:^{
                    self.view.frame = CGRectMake(-self.rightOffset, 0, self.size.width, self.size.height);
                }];
            }
                break;
            default:
                break;
        }
        _currentMenuState = RIGHT_ON_SCREEN;
    } else {
        [self hideSideMenuWithTag:2];
    }
}


-(void)instantiateLeftViewControllerWithTag:(int)tag
{
    self.leftPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    self.leftPanelViewController.view.tag = tag;
    self.leftPanelViewController.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.leftPanelViewController.view];
}

-(void)instantiateCenterViewControllerWithTag:(int)tag
{
    self.centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"];
    self.centerViewController.view.tag = tag;
    self.centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.centerViewController.view];
}



-(void)instantiateRightViewControllerWithTag:(int)tag
{
    self.rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    self.rightPanelViewController.view.tag = tag;
    float correctOffsetWhenInstantiate = self.interfaceOrientation == UIInterfaceOrientationPortrait ? self.view.frame.size.width: self.view.frame.size.height;
    self.rightPanelViewController.view.frame = CGRectMake(correctOffsetWhenInstantiate, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.rightPanelViewController.view];
}

-(void)move:(id)sender {
    
    CGRect startFrame, endFrame;
    
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];

	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        self.firstX = (self.interfaceOrientation == UIInterfaceOrientationPortrait)? [sender view].frame.origin.x : [sender view].frame.origin.y;
	}
    
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft: {
            translatedPoint = CGPointMake(self.view.frame.size.height/2, -self.firstX+translatedPoint.x);
            (translatedPoint.y > 0 )? [self instantiateLeftViewControllerWithTag:1]:[self instantiateRightViewControllerWithTag:2];
            startFrame = CGRectMake(0, -translatedPoint.y, self.view.frame.size.width, self.view.frame.size.height);
        }
            break;
        case UIInterfaceOrientationLandscapeRight: {
            translatedPoint = CGPointMake(self.view.frame.size.height/2, self.firstX+translatedPoint.x);
            (translatedPoint.y > 0)? [self instantiateLeftViewControllerWithTag:1]:[self instantiateRightViewControllerWithTag:2];
            startFrame = CGRectMake(0, translatedPoint.y, self.view.frame.size.width, self.view.frame.size.height);
        }
            break;
        case UIInterfaceOrientationPortrait: {
            translatedPoint = CGPointMake(self.firstX+translatedPoint.x, self.view.frame.size.height/2);
            (translatedPoint.x > 0)? [self instantiateLeftViewControllerWithTag:1]:[self instantiateRightViewControllerWithTag:2];
            startFrame = CGRectMake(translatedPoint.x, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
            break;
        default:
            break;
    }
    
    [[sender view] setFrame:startFrame];
    
   if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
       CGFloat finalX = (self.interfaceOrientation == UIInterfaceOrientationPortrait)? translatedPoint.x + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x) : translatedPoint.y + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
       
       if (finalX < -self.rightOffset/2 && self.currentMenuState == CENTER_ON_SCREEN) {
           finalX = -self.rightOffset;
           self.currentMenuState = RIGHT_ON_SCREEN;
       } else if(finalX > self.leftOffset/2 && self.currentMenuState == CENTER_ON_SCREEN) {
           finalX = self.leftOffset;
           self.currentMenuState = LEFT_ON_SCREEN;
       } else if(finalX > -self.rightOffset/2 || finalX <self.leftOffset/2) {
           finalX = 0;
           int menuToHide = _currentMenuState == LEFT_ON_SCREEN? 1:2;
           [self hideSideMenuWithTag:menuToHide];
       }
       
       switch (self.interfaceOrientation) {
           case UIInterfaceOrientationPortrait: {
               endFrame = CGRectMake(finalX, 0, self.view.frame.size.width, self.view.frame.size.height);
           }
               break;
           case UIInterfaceOrientationLandscapeLeft:{
               endFrame = CGRectMake(0, -finalX, self.view.frame.size.width, self.view.frame.size.height);
           }
               break;
           case UIInterfaceOrientationLandscapeRight: {
               endFrame = CGRectMake(0, finalX, self.view.frame.size.width, self.view.frame.size.height);
           }
               break;
           default:
               break;
       }
       [UIView beginAnimations:nil context:NULL];
       [UIView setAnimationDuration:.45];
       [[sender view] setFrame:endFrame];
       [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
       [UIView commitAnimations];
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
    [self hideSideMenuWithTag:1];
    [self hideSideMenuWithTag:2];
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
