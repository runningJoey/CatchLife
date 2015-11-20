//
//  ZYDetailTabBarBackController.m
//  CatchLife
//
//  Created by iMAC on 15/11/20.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "ZYDetailTabBarBackController.h"


@interface ZYDetailTabBarBackController ()

@end

@implementation ZYDetailTabBarBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    
    
    // Do any additional setup after loading the view.
}

#pragma 创建detail返回按钮栏
- (void)creatUI
{
    [self createTabBar];
    [self backbtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createTabBar
{
    _Tabbar = [[UIView alloc]init];
    
//    _Tabbar.backgroundColor = [UIColor grayColor];
    
    _Tabbar.frame = CGRectMake(0, __kScreenHeight - 49, __kScreenWidth, 49);
    
    
    
//    [self.view addSubview:_Tabbar];
}

//返回
- (void)backbtn
{
    UIButton *backButton = [MyBase baseCreateButtonFrame:CGRectMake(15, 5, 30, 30) imageName:@"bottom_btn_back" selectedImageName:nil highlightImageName:@"bottom_btn_back_active" target:self action:@selector(backLastPage)];
    [_Tabbar addSubview:backButton];
}


- (void)backLastPage
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
//    [self.navigationController popViewControllerAnimated:YES];
}

//分享
- (void)shareButton
{
    
}


-(BOOL)prefersStatusBarHidden
{
    return NO;
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    //默认是UIStatusBarStyleDefault;
//    return UIStatusBarStyleLightContent;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
