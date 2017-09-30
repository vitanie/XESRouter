//
//  XESBaseViewController.h
//  XESDemo
//
//  Created by luoshuai on 2017/6/10.
//  Copyright © 2017年 luoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XESRouterHader.h"
@interface XESBaseViewController : UIViewController

@property (nonatomic, strong) NSDictionary *ruterDictionary;
- (void)doback;
/**
 参数Block回调方法
 
 @param data 回调参数
 */
- (void)setCompletion:(id)data;

- (void)pushViewController:(NSNumber *)isPresented;
/**
 是否可以打开界面
 
 @param url 校验URL
 @return 是否可以打开
 */
- (BOOL)canOpenUrl:(NSString *)url;


/**
 注册URL KEY
 
 @param model 模块  路径 + 描述
 @param handler 回调
 */
+ (void)registerURLModel:(XESRouterModel *)model toHandler:(XESRouterHandler)handler;

/**
 进入下一级视图
 
 @param url 路径
 @param userInfo 用户参数
 @param ispresented 是否需要模态弹出界面  默认为NO
 @param completion 参数回调
 */
- (BOOL)pushController:(NSString *)url
           isPresented:(NSNumber *)ispresented
          withUserInfo:(NSDictionary *)userInfo
            completion:(void (^)(id result))completion;

/**
 进入下一级视图
 
 @param url 路径
 @param completion 参数回调
 */
- (BOOL)pushController:(NSString *)url completion:(void (^)(id result))completion;@end
