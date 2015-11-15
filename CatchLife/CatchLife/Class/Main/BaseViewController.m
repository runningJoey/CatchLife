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

{
    UIView *_navigationBar;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _navigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 64)];
    _navigationBar.backgroundColor = [UIColor colorWithRed:0.55 green:0.44 blue:0.87 alpha:1];
    [self.view addSubview:_navigationBar];
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256/255.0 green:arc4random() % 256/255.0 blue:arc4random() % 256/255.0 alpha:1];
    
}


//nav添加返回back按钮
- (void)addBackBtn
{
//    MyBase *backBtn = [MyBase baseCreateButtonFrame:CGRectMake(10, 0, <#CGFloat width#>, <#CGFloat height#>) imageName:<#(NSString *)#> selectedImageName:<#(NSString *)#> highlightImageName:<#(NSString *)#> target:<#(id)#> action:<#(SEL)#>];
}

- (void)addNavLabelFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)fontSize
{
    UILabel *label = [MyBase baseCreateLabelFrame:frame text:text textColor:[UIColor whiteColor] fontSize:fontSize textAlignment:NSTextAlignmentCenter];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
