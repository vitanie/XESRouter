//
//  XESRouter.m
//  XESDemo
//
//  Created by luoshuai on 2017/6/12.
//  Copyright © 2017年 luoshuai. All rights reserved.
//

#import "XESRouterPath.h"



@implementation XESRouterPath

+ (instancetype)sharedInstance{
    static dispatch_once_t pred = 0;
    __strong static XESRouterPath * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}




- (BOOL)canRouter:(NSString *)url{
    return YES;
}

- (NSArray *)getRouterList{
    NSDictionary *pathDictionary = [self settingPath];
    NSArray *keys = [pathDictionary allKeys];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSString *key in keys) {
        NSDictionary *dic = pathDictionary[key];
        XESRouterModel *model = [[XESRouterModel alloc]init];
        model.url = dic[@"url"];
        model.describe = dic[@"describe"];
        model.className = dic[@"className"];
        model.source = dic[@"source"];
        model.storyboardName = dic[@"storyboardName"];
        model.storyboardID = dic[@"storyboardID"];
        
        [array addObject:model];
    }
    return array;
}

- (XESRouterModel *)pathRouterModel:(NSString *)key{
    NSDictionary *pathDictionary = [self settingPath];
    NSDictionary *dic = pathDictionary[key];
    if (dic) {
        XESRouterModel *model = [[XESRouterModel alloc]init];
        model.describe = dic[@"describe"];
        model.source = dic[@"describe"];;
        model.url = dic[@"url"];;
        model.className = dic[@"className"];;
        model.storyboardName = dic[@"storyboardName"];;
        return model;
    }
    return nil;
    
}


- (NSDictionary *)settingPath{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"XESRouter" ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}
@end








