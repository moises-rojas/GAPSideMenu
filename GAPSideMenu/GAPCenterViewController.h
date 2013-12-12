//
//  GAPCenterViewController.h
//  GAPSideMenu
//
//  Created by Moises Rojas on 12/10/13.
//  Copyright (c) 2013 Moises Rojas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum slideMenuState
{
    CENTER_ON_SCREEN,
    RIGHT_ON_SCREEN,
    LEFT_ON_SCREEN
} SlideMenuState;

@interface GAPCenterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationBar *centerNavigationBar;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CGFloat leftOffset;
@property (nonatomic, assign) CGFloat rightOffset;


@end
