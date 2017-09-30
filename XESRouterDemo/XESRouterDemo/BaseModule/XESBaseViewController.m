//
//  XESBaseViewController.m
//  XESDemo
//
//  Created by luoshuai on 2017/6/10.
//  Copyright © 2017年 luoshuai. All rights reserved.
//

#import "XESBaseViewController.h"

@interface XESBaseViewController ()
@property (nonatomic, strong) NSNumber *presentedFlage;
@end

@implementation XESBaseViewController

- (void)setRuterDictionary:(NSDictionary *)ruterDictionary{
    if (_ruterDictionary != ruterDictionary) {
        _ruterDictionary = ruterDictionary;
        XESRouterModel *router = ruterDictionary[XESRouterParameterModel];
        NSLog(@"模块描述：%@",router.describe);
        
        NSDictionary *info = ruterDictionary[XESRouterParameterUserInfo];
        self.title = info[@"title"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn = [UIButton buttonWithType:0];
    [btn setFrame:CGRectMake(0, 0, 40, 40)];
    [btn setTitle:@"<" forState:0];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(doback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    itemBar.tag = 1000;
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = -10;
    [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem, itemBar]];
    
    
}



- (void)doback{
    UINavigationController *nav =  [UIViewController currentNavigationViewController];
    if (nav.topViewController == self && [nav.viewControllers count] > 1) {
        [nav popViewControllerAnimated:YES];
    }else{
        [nav dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)pushViewController:(NSNumber *)isPresented{
    self.presentedFlage = isPresented;
    if (self.presentedFlage && [self.presentedFlage boolValue]) {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self];
        [[UIViewController currentNavigationViewController] presentViewController:nav animated:YES completion:nil];
    }else{
        [[UIViewController currentNavigationViewController] pushViewController:self animated:YES];
    }
}


- (void)setCompletion:(id)data{
    XESRouterCompletion completion = self.ruterDictionary[XESRouterParameterCompletion];
    if (completion) {
        completion(data);
    }
}

#pragma mark - 注册
+ (void)registerURLModel:(XESRouterModel *)model toHandler:(XESRouterHandler)handler{
    [XESRouter registerURLModel:model toHandler:handler];
}

- (BOOL)canOpenUrl:(NSString *)url{
    return [XESRouter canOpenURL:url];
}

#pragma mark - 由路径进入视图
- (BOOL)pushController:(NSString *)url completion:(void (^)(id result))completion{
    return [self pushController:url isPresented:@NO withUserInfo:nil completion:completion];
}

- (BOOL)pushController:(NSString *)url
           isPresented:(NSNumber *)ispresented
          withUserInfo:(NSDictionary *)userInfo
            completion:(void (^)(id result))completion{
    
    if (!url) {return NO;}
    
    [XESRouter openURL:url
           isPresented:ispresented
          withUserInfo:userInfo
            completion:completion];
    return YES;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
          "     %@   ------->   dealloc                  \n"
          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n",[self class]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
