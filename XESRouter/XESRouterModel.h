//
//  XESRouterModel.h
//  XESRouter
//
//  Created by luoshuai on 2017/6/15.
//  Copyright © 2017年 luoshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XESRouterModel : NSObject
/**
 路径描述
 */
@property (nonatomic, strong) NSString * describe;

/**
 类的数据源，code = 0    xib = 2    storyboard = 3
 */
@property (nonatomic, strong) NSString * source;
/**
 URL
 */
@property (nonatomic, strong) NSString * url;

/**
 类名
 */
@property (nonatomic, strong) NSString *className;

/**
 storyboard名称
 */
@property (nonatomic, strong) NSString *storyboardName;
/**
 storyboard ID
 */
@property (nonatomic, strong) NSString *storyboardID;

/**
 存放额外数据
 */
@property (nonatomic, strong) id other;

/**
 回调一个带URL模型
 
 @param url 需要注册的URL
 @return 模型
 */
+ (XESRouterModel *)urlRouterKey:(NSString *)url;

@end
