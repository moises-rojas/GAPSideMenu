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
    [self.view addSubview:self.leftPanelViewController.view];
    self.leftPanelViewController.view.tag = tag;
    self.leftPanelViewController.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)instantiateRightViewControllerWithTag:(int)tag
{
    self.rightPanelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    [self.view addSubview:self.rightPanelViewController.view];
    self.rightPanelViewController.view.tag = tag;
    self.rightPanelViewController.view.frame = CGRectMake(self.view.frame.size.height, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)move:(id)sender {
    
    CGRect motionFrame, endFrame;
    
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];

	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        self.firstX = [sender view].frame.origin.x;
	}
    
	translatedPoint = CGPointMake(self.firstX+translatedPoint.x, self.view.frame.size.height/2);
    if (translatedPoint.x > 0) {
        [self instantiateLeftViewControllerWithTag:1];
    } else {
        [self instantiateRightViewControllerWithTag:2];
    }
    
    //[[sender view] setFrame:CGRectMake(translatedPoint.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    motionFrame = CGRectMake(translatedPoint.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    
   if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
    CGFloat finalX = translatedPoint.x + (.45*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
       NSLog(@"UIPanGestureRecognizer*)sender velocityInView: %f",.45*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
       NSLog(@"final X: %f",finalX);
       switch (self.interfaceOrientation) {
           case UIInterfaceOrientationPortrait: {
               NSLog(@"translatedPoint: %f", translatedPoint.x);
               if (finalX < 0 || finalX < self.leftOffset/2) {
                   finalX = 0;
                   self.currentMenuState = CENTER_ON_SCREEN;
               } else if(finalX > self.leftOffset/2) {
                   finalX = self.leftOffset;
                   self.currentMenuState = LEFT_ON_SCREEN;
               }
               endFrame = CGRectMake(finalX, 0, self.view.frame.size.width, self.view.frame.size.height);
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
