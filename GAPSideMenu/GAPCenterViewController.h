//
//  GAPCenterViewController.h
//  GAPSideMenu
//
//  Created by Moises Rojas on 12/10/13.
//  Copyright (c) 2013 Moises Rojas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

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

@property (nonatomic, assign) CGFloat firstX;
@property (nonatomic, assign) CGFloat firstY;

- (void)showLeftPanel;
- (void)showRightPanel;

@end
