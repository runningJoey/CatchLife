
//  RecreationController.m
//  CatchLife
//
//  Created by iMAC on 15/11/15.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "RecreationController.h"
#import "ZYDownLoader.h"
#import "WeixinModel.h"
#import "WXModel.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "WXCell.h"

#import <MJRefresh.h>
#import "DetailController.h"


@interface RecreationController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

{
    NSMutableArray *_dataArray;
    NSInteger _index;
}

@property (nonatomic, strong)UICollectionView *collectionView;


@end

@implementation RecreationController


- (void)loadMoreData
{
    
    __weak RecreationController *weakSelf = self;
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        NSLog(@"进入header刷新状态后会自动调用这个block");
        
        
        
        [weakSelf downLoadWXData:YES];
        
    }];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        NSLog(@"进入footer刷新状态后会自动调用这个block");
         [weakSelf downLoadWXData:NO];
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createUI];
    [self downLoadWXData:YES];
    _index = 2;
    
    
    [self setNav];
}


- (void)setNav
{

    [self addNavLabelFrame:CGRectMake(__kScreenWidth - 200, 0, 60, 44) text:@"精选" fontSize:17 isCenter:YES];
}


- (void)createUI
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    CGFloat margin = 10;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, margin, 10, margin);
    flowLayout.itemSize = CGSizeMake(__kScreenWidth, 200);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth, __kScreenHeight - 64) collectionViewLayout:flowLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"WXCell" bundle:nil] forCellWithReuseIdentifier:@"WXCell"];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.view bringSubviewToFront:_navigationBar];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    [self loadMoreData];
    
 

}




- (void)downLoadWXData:(BOOL)once
{
    /**
     pno	int	否	当前页数，默认1
     ps	int	否	每页返回条数，最大100，默认20
     key	string	是	应用APPKEY(应用详细页查询)
     dtype	string	否	返回数据的格式,xml或json，默认json
     */
    
//    NSDictionary *param = @{
//                          @"pno":@"1",
//                          @"pno":@"20",
//
//                          };
   
    
    NSDictionary *param = nil;
    if (once) {
        
        [_dataArray removeAllObjects];
        
    } else {
        _index += 1;
       param = @{@"pno":@(_index)};
    }
    
    
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH424aa698c686e5169f55c0c0b9abbc70"];
    
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    __weak RecreationController *weakSelf = self;
    
    [juheapi executeWorkWithAPI:@"http://v.juhe.cn/weixin/query" APIID:@"147" Parameters:param Method:@"get" Success:^(id responseObject){
        if ([[param objectForKey:@"dtype"] isEqualToString:@"xml"]) {
            NSLog(@"***xml*** \n %@",responseObject);
        }else{
            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
            if (!error_code) {
            
               NSArray *array = responseObject[@"result"][@"list"];
                
              
                
                
                NSMutableArray *arrM = [WXModel arrayOfModelsFromDictionaries:array error:nil];
                [_dataArray addObjectsFromArray:arrM];
                
                [weakSelf performSelectorOnMainThread:@selector(refresh) withObject:nil waitUntilDone:nil];
                
                NSLog(@"%ld",_dataArray.count);
                
                
//                NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//                WeixinModel *model = [[WeixinModel alloc]initWithData:data error:nil];
                
                
                
            }else{
                NSLog(@"%@", responseObject[@"reason"]);
            }
        }
    } Failure:^(NSError *error) {
        NSLog(@"error:%@",error.description);
        
    }];

}


- (void)refresh
{
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -数据源协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return _dataArray.count;
    
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WXCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WXCell" forIndexPath:indexPath];
    
    if (_dataArray.count == 0) {
        return cell;
    }
    
    cell.model = _dataArray[indexPath.item];
    
    
    return cell;
}

#pragma mark -代理协议方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WXModel *model = _dataArray[indexPath.item];
    
    DetailController *detailVC = [[DetailController alloc]initWithUrl:model.url];
    detailVC.navigationController.navigationBar.hidden = YES;
//    [self.navigationController pushViewController:detailVC animated:YES];
    [self presentViewController:detailVC animated:YES completion:nil];
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"2");
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"34124323");
}// called when scrolling animation finished. may be called immediately if already at top


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"432423432432423");
    
 
}


@end
