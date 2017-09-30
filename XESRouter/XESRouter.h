//
//  XESRouter.h
//  XESCommon
//
//  Created by luoshuai on 2017/6/12.
//  Copyright © 2017年 luoshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XESRouterModel.h"

extern NSString *const XESRouterParameterURL;
extern NSString *const XESRouterParameterCompletion;
extern NSString *const XESRouterParameterUserInfo;
extern NSString *const XESRouterParameterPresented;
extern NSString *const XESRouterParameterModel;
/**
 *  routerParameters 里内置的几个参数会用到上面定义的 string
 */
typedef void (^XESRouterHandler)(NSDictionary *routerParameters);

/**
 *  需要返回一个 object，配合 objectForURL: 使用
 */
typedef id (^XESRouterObjectHandler)(NSDictionary *routerParameters);

/**
 回调Block
 
 @param result 回调参数
 */
typedef void (^XESRouterCompletion)(id result);


@interface XESRouter : NSObject

/**
 设置界面与界面之间跳转的间隔时间
 
 @param time 默认0.5毫秒
 */
+ (void)filterRouterTime:(float)time;

/**
 *  注册 URLPattern 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
 *
 *  @param model      带上 scheme，如 mgj://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 */
+ (void)registerURLModel:(XESRouterModel *)model toHandler:(XESRouterHandler)handler;

/**
 *  注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
 *
 *  @param model cheme，如 mgj://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 *                    自带的 key 为 @"url" 和 @"completion" (如果有的话)
 */
+ (void)registerURLModel:(XESRouterModel *)model toObjectHandler:(XESRouterObjectHandler)handler;

/**
 *  取消注册某个 URL Pattern
 *
 *  @param URLPattern KEY
 */
+ (void)deregisterURLPattern:(NSString *)URLPattern;

/**
 *  打开此 URL
 *  会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
 *
 *  @param URL 带 Scheme，如 mgj://beauty/3
 *  @param ispresented 是否需要模态弹出界面  默认为NO
 */
+ (BOOL)openURL:(NSString *)URL isPresented:(NSNumber *)ispresented;

/**
 *  打开此 URL，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 *  @param ispresented 是否需要模态弹出界面  默认为NO
 */
+ (BOOL)openURL:(NSString *)URL isPresented:(NSNumber *)ispresented completion:(XESRouterCompletion )completion;

/**
 *  打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 *  @param userInfo 附加参数
 *  @param ispresented 是否需要模态弹出界面  默认为NO
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (BOOL)openURL:(NSString *)URL isPresented:(NSNumber *)ispresented  withUserInfo:(NSDictionary *)userInfo completion:(XESRouterCompletion)completion;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL KEY
 */
+ (id)objectForURL:(NSString *)URL;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL  KEY
 *  @param userInfo 参数
 */
+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo;

/**
 *  是否可以打开URL
 *
 *  @param URL KEY
 *
 *  @return 是否可以打开
 */
+ (BOOL)canOpenURL:(NSString *)URL;

@end
