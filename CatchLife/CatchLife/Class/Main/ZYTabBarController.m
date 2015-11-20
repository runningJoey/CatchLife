//
//  CLTabBarController.m
//  CatchLife
//
//  Created by iMAC on 15/11/15.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "ZYTabBarController.h"
#import "BaseViewController.h"
#import "LifeController.h"
#import "RecreationController.h"
#import "GroupBuyController.h"
#import "MyController.h"

#import "NewsController.h"
#import "MyBase.h"

@interface ZYTabBarController ()

{
    UIView *_tabBarBGView;
    NSInteger _count;
}

@end

@implementation ZYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabBar];
    
    [self createControllers];
    
}


- (void)createTabBar
{
    self.tabBar.hidden = 1;
    _tabBarBGView.userInteractionEnabled = YES;
    
    _tabBarBGView = [[UIView alloc]initWithFrame:self.tabBar.frame];
    _tabBarBGView.backgroundColor = __bgColor;
    [self.view addSubview:_tabBarBGView];
    
    NSArray *titleArray = @[@"生活", @"精选", @"团购", @"新闻", @"我"];
    
    _count = titleArray.count;
    

    CGFloat W = __kScreenWidth / _count;
    CGFloat H = 44;
   
    for (int i = 0; i < _count ; i++) {
        
        CGRect frame = CGRectMake(i * W, 0, W, H);
        UIButton *button = [MyBase baseCreateButtonFrame:frame imageName:[NSString stringWithFormat:@"tabbar%d", i + 1] selectedImageName:[NSString stringWithFormat:@"tabbar%ds", i + 1] highlightImageName:[NSString stringWithFormat:@"tabbar%d", i + 1] target:self action:@selector(btnClick:)];
        
        [_tabBarBGView addSubview:button];
        button.tag = 300 + i;
    
        UILabel *label = [MyBase baseCreateLabelFrame:CGRectMake(0, 38, W, 9) text:titleArray[i] textColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] fontSize:9 textAlignment:NSTextAlignmentCenter];
        [button addSubview:label];
        label.tag = 400;
        
        if (i == 0) {
            button.selected = YES;
            label.textColor = [UIColor whiteColor];
        }
    }
}

//点击事件
- (void)btnClick:(UIButton *)btn
{
    //拿到上一次的btn和label
    UIButton *lastBtn = (UIButton *)[_tabBarBGView viewWithTag:self.selectedIndex + 300];
    lastBtn.selected = NO;
    
    UILabel *lastLabel = (UILabel *)[lastBtn viewWithTag:400];
    lastLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    
    btn.selected = YES;
    UILabel *label = (UILabel *)[btn viewWithTag:400];
    label.textColor = [UIColor whiteColor];
    
    self.selectedIndex = btn.tag - 300;
    
}


- (void)createControllers
{
    
    NSArray *clsArray = @[@"LifeController", @"RecreationController", @"GroupBuyController", @"NewsController", @"MyController"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _count ; i++) {
        Class cls = NSClassFromString(clsArray[i]);
        UIViewController *vc = [[cls alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        nvc.navigationBar.hidden = YES;
        [array addObject:nvc];
    }
    self.viewControllers = array;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
