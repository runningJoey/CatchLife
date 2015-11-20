//
//  DetailController.m
//  CatchLife
//
//  Created by iMAC on 15/11/20.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "DetailController.h"
#import "ProgressHUD.h"

@interface DetailController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end


@implementation DetailController



-(instancetype)initWithUrl:(NSString *)url
{
    if (self = [super init]) {
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, __kScreenHeight)];
        [self.view addSubview:self.webView];
        
        [self.webView addSubview:_Tabbar];
        
        self.view.backgroundColor = [UIColor whiteColor];

        self.webView.delegate = self;

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self.webView loadRequest:request];
    
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [ProgressHUD showOnView:self.webView];
   
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD hideAfterSuccessOnView:self.webView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [ProgressHUD hideAfterFailOnView:self.webView];
}



@end
