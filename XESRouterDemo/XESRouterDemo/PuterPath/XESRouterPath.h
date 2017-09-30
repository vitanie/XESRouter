//
//  XESRouterPath.h
//  XESDemo
//
//  Created by luoshuai on 2017/6/12.
//  Copyright © 2017年 luoshuai. All rights reserved.
//
#define  ROUTERURL [XESRouterPath sharedInstance]
#import <Foundation/Foundation.h>
#import "XESRouterHader.h"






@interface XESRouterPath : NSObject

/**
 路由单利

 @return self
 */
+ (instancetype)sharedInstance;
/**
 根据key获取Router模型

 @param key 键值
 @return 返回model
 */
- (XESRouterModel *)pathRouterModel:(NSString *)key;

/**
 获取多有本地plist数据源
 
 @return 数据 XESRouterModel
 */
- (NSArray *)getRouterList;


@end
