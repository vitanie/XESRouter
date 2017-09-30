//
//  XESLoginVC.m
//  XESRouterDemo
//
//  Created by luoshuai on 2017/7/12.
//  Copyright © 2017年 XES. All rights reserved.
//

#import "XESLoginVC.h"

@interface XESLoginVC ()

@end

@implementation XESLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:0];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"下一层" forState:0];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)doback{
    NSInteger countViewContoller = [self.navigationController.viewControllers count];
    if (countViewContoller > 8) {
        
        NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [vcArray removeLastObject];
        [vcArray removeLastObject];
        [vcArray removeLastObject];
        [self.navigationController setViewControllers:vcArray animated:YES];
    }
    [super doback];
}

- (void)nextClick{
    NSInteger number = [self.title intValue];
    number++;
    NSString *str = [NSString stringWithFormat:@"%@",@(number)];
    [self pushController:@"xesrouter://test/xib/view" isPresented:@NO withUserInfo:@{@"title":str} completion:^(id result) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
