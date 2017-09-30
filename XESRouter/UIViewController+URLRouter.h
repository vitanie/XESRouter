//
//  UIViewController+URLRouter.h
//  RouterDemo
//
//  Created by luoshuai on 2017/3/3.
//  Copyright © 2017年 luoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (URLRouter)

+ (UIViewController *)currentViewController;

+ (UINavigationController *)currentNavigationViewController;

@end

