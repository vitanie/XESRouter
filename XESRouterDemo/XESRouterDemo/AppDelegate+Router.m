//
//  AppDelegate+Router.m
//  XESRouter
//
//  Created by luoshuai on 2017/6/19.
//  Copyright © 2017年 luoshuai. All rights reserved.
//

#import "AppDelegate+Router.h"
#import "XESRouterHader.h"
#import "XESRouterPath.h"
#import "XESBaseViewController.h"
#import "XESRouterHader.h"
@implementation AppDelegate (Router)
- (void)initRouter{
    NSLog(@"app地址：%@",NSHomeDirectory());
    
    NSArray *rouerArray = [ROUTERURL getRouterList];
    for (XESRouterModel *model in rouerArray) {
        
        [XESRouter registerURLModel:model
                          toHandler:^(NSDictionary *routerParameters) {
                              
                              if ([model.source isEqualToString:@"0"]) {
                                  [self codeAllocViewController:routerParameters];
                              }else if ([model.source isEqualToString:@"1"]){
                                  [self xibAllocViewController:routerParameters];
                              }else if ([model.source isEqualToString:@"2"]){
                                  [self storyboardAllocViewController:routerParameters];
                              }else{
                              }
                     }];    
        
    }
    
}
//手写代码
- (void)codeAllocViewController:(NSDictionary *)routerParameters{
    XESRouterModel *model = routerParameters[XESRouterParameterModel];
    NSNumber *presented = routerParameters[XESRouterParameterPresented];
    Class class = NSClassFromString(model.className);
    XESBaseViewController *tabVC = [[class alloc]init];
    tabVC.ruterDictionary = routerParameters;
    [tabVC pushViewController:presented];
}
//xib进入方法
- (void)xibAllocViewController:(NSDictionary *)routerParameters{
    XESRouterModel *model = routerParameters[XESRouterParameterModel];
    NSNumber *presented = routerParameters[XESRouterParameterPresented];

    if ([model isKindOfClass:[XESRouterModel class]]) {
        
        Class class = NSClassFromString(model.className);
        XESBaseViewController *tabVC = [[class alloc] initWithNibName:model.className bundle:nil];
        tabVC.ruterDictionary = routerParameters;
        [tabVC setHidesBottomBarWhenPushed:YES];
        [tabVC pushViewController:presented];
    }
}

//storyboard进入方法
- (void)storyboardAllocViewController:(NSDictionary *)routerParameters{
    
    XESRouterModel *model = routerParameters[XESRouterParameterModel];
    NSNumber *presented = routerParameters[XESRouterParameterPresented];
    if ([model isKindOfClass:[XESRouterModel class]]) {
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:model.storyboardName bundle:nil];
        XESBaseViewController *tabVC = [mainSB instantiateViewControllerWithIdentifier:model.storyboardID];
        tabVC.ruterDictionary = routerParameters;
        [tabVC setHidesBottomBarWhenPushed:YES];
        [tabVC pushViewController:presented];
    }
}



- (void)pushFormUrl:(NSString *)url{
    if (url.length > 0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(pushUrl:) withObject:url afterDelay:1];
    }
}


- (void)pushUrl:(NSString *)url{
    if ([XESRouter canOpenURL:url]) {
        [XESRouter openURL:url isPresented:@NO];
    }else{
        NSLog(@"跳转失败");
    }
    
}







@end
