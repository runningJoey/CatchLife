//
//  BaseViewController.m
//  CatchLife
//
//  Created by iMAC on 15/11/15.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "BaseViewController.h"
#import "MyBase.h"

@interface BaseViewController ()



@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 20)];
    topView.backgroundColor = __bgColor;

    [self.view addSubview: topView];
    _navigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 20, __kScreenWidth, 44)];
    _navigationBar.backgroundColor = __bgColor;
    [self.view addSubview:_navigationBar];
    
    
    [self.view bringSubviewToFront:_navigationBar];
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256/255.0 green:arc4random() % 256/255.0 blue:arc4random() % 256/255.0 alpha:1];
    
}


//nav添加返回back按钮
- (void)addBackBtn
{
    UIButton *backBtn = [MyBase baseCreateButtonFrame:CGRectMake(10, 0, 44, 44) imageName:@"首页-返回" selectedImageName:nil highlightImageName:nil target:self action:@selector(back)];
    
    [_navigationBar addSubview:backBtn];
    
}


- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)addNavLabelFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)fontSize isCenter:(BOOL)isCenter
{
    UILabel *label = [MyBase baseCreateLabelFrame:frame text:text textColor:[UIColor whiteColor] fontSize:fontSize textAlignment:NSTextAlignmentCenter];
    if (isCenter) {
        CGPoint po = CGPointMake(_navigationBar.frame.size.width / 2, 22);
        label.center = po;
        
    }
    
    
    
    [_navigationBar addSubview:label];
}

- (void)addNavImageViewFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *imageView = [MyBase baseCreateImageViewFrame:frame imageName:imageName];
    [_navigationBar addSubview:imageView];
}

- (void)addNavBtnFrame:(CGRect)frame imageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName text:(NSString *)text target:(id)target action:(SEL)action
{
    UIButton *btn = [MyBase baseCreateButtonFrame:frame imageName:imageName selectedImageName:imageName highlightImageName:highlightImageName target:target action:action];
    [_navigationBar addSubview:btn];
    
    UILabel *label = [MyBase baseCreateLabelFrame:CGRectMake(0, frame.size.height - 15, frame.size.width, 11) text:text textColor:[UIColor whiteColor] fontSize:11 textAlignment:NSTextAlignmentCenter];
    [btn addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    //默认是UIStatusBarStyleDefault;
    return UIStatusBarStyleLightContent;
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
