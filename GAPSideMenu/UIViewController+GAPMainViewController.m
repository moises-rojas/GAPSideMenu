//
//  UIViewController+GAPMainViewController.m
//  GAPSideMenu
//
//  Created by Moises Rojas on 12/19/13.
//  Copyright (c) 2013 Moises Rojas. All rights reserved.
//

#import "UIViewController+GAPMainViewController.h"

@implementation UIViewController (GAPMainViewController)

-(GAPCenterViewController *)mainViewController {

    return (GAPCenterViewController *) [self parentViewController];
}

@end
