//
//  GAPCenterViewController.h
//  GAPSideMenu
//
//  Created by Moises Rojas on 12/10/13.
//  Copyright (c) 2013 Moises Rojas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "GAPLeftMenuViewController.h"

typedef enum slideMenuState
{
    CENTER_ON_SCREEN,
    RIGHT_ON_SCREEN,
    LEFT_ON_SCREEN
} SlideMenuState;

@interface GAPCenterViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *centerNavigationBar;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CGFloat leftOffset;
@property (nonatomic, assign) CGFloat rightOffset;

@property (nonatomic, retain) GAPLeftMenuViewController *leftPanelViewController;
@property (nonatomic, retain) UIViewController *rightPanelViewController;
@property (nonatomic, retain) UIViewController *centerViewController;

@property (nonatomic, assign) CGFloat firstX;
@property (nonatomic, assign) CGFloat firstY;


- (void)showLeftPanel;
- (void)showRightPanel;

- (void)openAnotherView;

- (void)shouldHaveLeftMenu:(BOOL)leftMenu;
- (void)shouldHaveRightMenu:(BOOL)rightMenu;

@end
