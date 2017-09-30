//
//  XESTestXibVC.m
//  XESDemo
//
//  Created by luoshuai on 2017/7/11.
//  Copyright © 2017年 luoshuai. All rights reserved.
//

#import "XESTestXibVC.h"

@interface XESTestXibVC ()

@end

@implementation XESTestXibVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)nextClick:(id)sender {
    NSInteger number = [self.title intValue];
    number++;
    NSString *str = [NSString stringWithFormat:@"%@",@(number)];
    [self pushController:@"xesrouter://login/view" isPresented:@NO withUserInfo:@{@"title":str} completion:^(id result) {
        
    }];
    [self setCompletion:nil];
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
