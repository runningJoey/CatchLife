
//
//  NewsController.m
//  CatchLife
//
//  Created by iMAC on 15/11/15.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "NewsController.h"

#import "FDSlideBar.h"
#import "TableViewCell.h"
#import "ProgressHUD.h"
@interface NewsController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
@property (strong, nonatomic) FDSlideBar *slideBar;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *urlStrArray;


@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = __bgColor;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self setupSlideBar];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

// Set up a slideBar and add it into view
- (void)setupSlideBar {
    FDSlideBar *sliderBar = [[FDSlideBar alloc] init];
    sliderBar.backgroundColor = __bgColor;
    
    // Init the titles of all the item
    sliderBar.itemsTitle = @[@"百度新闻", @"网易新闻", @"搜狐新闻", @"凤凰新闻", @"新浪新闻", @"腾讯新闻"];
    
    self.urlStrArray = @[@"http://m.baidu.com/news",
                         @"http://3g.163.com/touch/news",
                         @"http://m.sohu.com" ,
                         @"http://3g.ifeng.com/",
                         @"http://sina.cn/",
                         @"http://info.3g.qq.com"
                        ];
    
    // Set some style to the slideBar
    sliderBar.itemColor = [UIColor whiteColor];
    sliderBar.itemSelectedColor = [UIColor orangeColor];
    sliderBar.sliderColor = [UIColor orangeColor];
    
    // Add the callback with the action that any item be selected
    [sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }];
    [self.view addSubview:sliderBar];
    _slideBar = sliderBar;
}

// Set up a tableView to show the content
- (void)setupTableView {
    // The frame of tableView, be care the width and height property
    CGRect frame = CGRectMake(0, 0, CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(self.slideBar.frame), CGRectGetWidth(self.view.frame));
    
    
    

    self.tableView = [[UITableView alloc] initWithFrame:frame];
    [self.view addSubview:self.tableView];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    // Register the custom cell
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ContentCell"];
    
    // Set the tableView center in the bottom of view. so after rotating, it shows rightly
    self.tableView.center = CGPointMake(CGRectGetWidth(self.view.frame) * 0.5, CGRectGetHeight(self.view.frame) * 0.5 + CGRectGetMaxY(self.slideBar.frame) * 0.5);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Rotate the tableView 90 angle anticlockwise
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.pagingEnabled = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.slideBar.itemsTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ContentCell"];
  
    // Rotate the cell's content 90 angle clockwise to show them rightly
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    
    NSURL *url = [NSURL URLWithString:self.urlStrArray[indexPath.row]];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    cell.webView.backgroundColor = [UIColor whiteColor];
    [cell.webView loadRequest:request];
    cell.webView.delegate = self;
    
    
    return cell;
}






#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Height retrun the width of screen
    return CGRectGetWidth(self.view.frame);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:scrollView.contentOffset];
    
    // Select the relating item when scroll the tableView by paging.
    [self.slideBar selectSlideBarItemAtIndex:indexPath.row];
}

#pragma mark -webView协议方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    

    
    [ProgressHUD showOnView:webView];
    NSLog(@"开始加载");
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    [ProgressHUD hideAfterSuccessOnView:webView];
    NSLog(@"完成加载");
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [ProgressHUD hideAfterFailOnView:webView];
}


@end