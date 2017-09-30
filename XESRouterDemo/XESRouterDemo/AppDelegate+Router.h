//
//  AppDelegate+Router.h
//  XESRouter
//
//  Created by luoshuai on 2017/6/19.
//  Copyright © 2017年 luoshuai. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Router)

/**
 初始化路由配置
 */
- (void)initRouter;

/**
 跳转路由路径

 @param url 路由路径
 */
- (void)pushFormUrl:(NSString *)url;
@end
