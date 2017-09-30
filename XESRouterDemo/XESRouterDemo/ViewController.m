//
//  ViewController.m
//  XESRouterDemo
//
//  Created by 徐强 on 17/6/26.
//  Copyright © 2017年 XES. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate+Router.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextView; 
@property (nonatomic , strong) NSNumber * selected;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktap)];
    [self.view addGestureRecognizer:tap];
}
- (void)clicktap{
    [self.view endEditing:YES];
}
- (IBAction)pushXIB:(id)sender {
    [self pushController:@"xesrouter://test/xib/view?user=彭越&passwrod=123456"
             completion:^(id result) {
                 NSLog(@"回调");
             }];
}

- (IBAction)presentXIB:(id)sender {
    
    [self pushController:@"xesrouter://test/xib/view"
             isPresented:@YES
            withUserInfo:@{@"user":@"彭越",@"passwrod":@"123456"}
              completion:^(id result) {
        NSLog(@"回调");
    }];
}

- (IBAction)pushStoryboard:(id)sender {
    [self pushController:@"xesrouter://test/storyboard/view" isPresented:@NO withUserInfo:@{@"title":@"1"} completion:^(id result) {
        
    }];
}

- (IBAction)presentStoryboard:(id)sender {
    [self pushController:@"xesrouter://test/storyboard/view" isPresented:@YES withUserInfo:@{@"title":@"1"} completion:^(id result) {
        
    }];
}

- (IBAction)pushCode:(id)sender {
    [self pushController:@"xesrouter://login/view" isPresented:@NO withUserInfo:@{@"title":@"1"} completion:^(id result) {
        
    }];
}

- (IBAction)presentCode:(id)sender {
    [self pushController:@"xesrouter://login/view" isPresented:@YES withUserInfo:@{@"title":@"1"} completion:^(id result) {
        
    }];
}

- (IBAction)simulationClick:(id)sender {
    for (NSInteger i = 0; i <= 5; i++) {
        [self pushController:@"xesrouter://test/xib/view?user=彭越&passwrod=123456"
                  completion:^(id result) {
                      NSLog(@"回调");
                  }];
    }
}

- (IBAction)submitPush:(id)sender {
    

    NSLog(@"self.inputTextView.text==%@",self.inputTextView.text);
    [self pushController:self.inputTextView.text isPresented:self.selected withUserInfo:@{@"title":@"1"} completion:^(id result) {
        
    }];
}

- (IBAction)isPushClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.selected = @(sender.selected);
}
- (IBAction)registerURLClick:(id)sender {
    
    
    long long fistdate = [[NSDate date] timeIntervalSince1970]*1000;
    
    NSInteger count = [self.inputTextView.text integerValue];
    
    for (NSInteger i = 0; i < count; i++) {
        
        XESRouterModel *model = [[XESRouterModel alloc] init];
        model.describe = [NSString stringWithFormat:@"%ld",i];
        model.source = @"0";
        model.url = [NSString stringWithFormat:@"xesrouter://login/view/q-%ld",i];
        model.className = @"XESTestXibVC";
        
        [XESRouter registerURLModel:model
                          toHandler:^(NSDictionary *routerParameters) {
                              NSLog(@"路径 => %@",routerParameters);
                              
                              if ([model.source isEqualToString:@"0"]) {
                                  [self codeAllocViewController:routerParameters];
                              }else if ([model.source isEqualToString:@"1"]){
                                  [self xibAllocViewController:routerParameters];
                              }else if ([model.source isEqualToString:@"2"]){
                                  [self storyboardAllocViewController:routerParameters];
                              }else{
                                  NSLog(@"初始化%@错误",model.className);
                              }
                          }];
    }
    long long lastdata = [[NSDate date] timeIntervalSince1970]*1000;
    NSLog(@"存储%ld个，使用耗时：%lld毫秒",count,lastdata - fistdate);
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
        XESBaseViewController *tabVC = [mainSB instantiateViewControllerWithIdentifier:model.className];
        tabVC.ruterDictionary = routerParameters;
        [tabVC setHidesBottomBarWhenPushed:YES];
        [tabVC pushViewController:presented];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSNumber *)selected{
    if (!_selected) {
        return @NO;
    }
    return _selected;
}
@end






