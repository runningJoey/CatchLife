//
//  LifeController.m
//  CatchLife
//
//  Created by iMAC on 15/11/15.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "LifeController.h"
#import "ZYDownLoader.h"
#import "AFHTTPRequestOperationManager.h"
#import "WeatherHeaderListCell.h"
#import "WeatherModel.h"
#import "MyCollectionViewCell.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "ZYChinaseToEng.h"

#define ApiKey (@"331de3d0c4d63b249c846bf4d3c4aac3")



@interface LifeController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,MAMapViewDelegate, AMapSearchDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    NSString *_city;
    
    NSString *_cytyChs;
}
@property (nonatomic, strong)NSMutableArray *dataArrayWeather;

@property (nonatomic, strong)UICollectionView *wetherColleView;


@end

@implementation LifeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMap];
    [self downloaderIp];
    
    [self setNav];
    
}


- (void)setNav
{
     [self addNavBtnFrame:CGRectMake(__kScreenWidth - 40, 7, 30, 30) imageName:@"location" highlightImageName:nil text:nil target:self action:@selector(location:)];
    

    [self addNavLabelFrame:CGRectMake(__kScreenWidth - 200, 0, 60, 44) text:@"生活" fontSize:17 isCenter:YES];
}


- (void)location:(id)sender
{
    NSLog(@"定位");
}

- (void)initMap
{
    [MAMapServices sharedServices].apiKey = ApiKey;
    [AMapSearchServices sharedServices].apiKey = ApiKey;
    [self initMapView];
    [self initSearch];
    [self createWeatherView];
    
   
    
}

- (void)downloaderIp
{
    NSString *path = @"http://apis.juhe.cn/ip/ip2addr";
    NSString *api_id = @"1";
    NSString *method = @"GET";
    NSDictionary *param = @{@"ip":@"www.bilibili.com", @"dtype":@"json"};
    
    ZYDownLoader *dw = [[ZYDownLoader alloc]init];
    [dw downloadWithApipath:path api_id:api_id method:method param:param finishBlock:^(NSData *data) {
//        NSLog(@"%@", data);
    } failBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    //天气数据
    
    
}



#pragma mark -数据懒加载
- (NSMutableArray *)dataArrayWeather
{
    if (_dataArrayWeather == nil) {
        _dataArrayWeather = [NSMutableArray array];
    }
    
    return _dataArrayWeather;
}


- (void)createWeatherView
{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 10;
    
    
    self.wetherColleView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth, 180) collectionViewLayout:flowLayout];
    
    UIImageView *HeaderImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weatherTopBG"]];
    self.wetherColleView.backgroundView = HeaderImageView;
    
    
    
    self.wetherColleView.delegate = self;
    self.wetherColleView.dataSource = self;
    
    [self.view addSubview:self.wetherColleView];
    
    [self.wetherColleView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [self.wetherColleView registerNib:[UINib nibWithNibName:@"WeatherHeaderListCell" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
    
    
    
}



#pragma mark -通过城市名称获取天气Modelarray
- (void)requestWeatherDataByCityId:(NSString *)cityname
{
    
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": @"afdbab51770242bf4d4c4b2effa1d9ed" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://a.apix.cn/heweather/x3/free/weather?city=%@", cityname]]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        NSArray *array = dic[@"HeWeather data service 3.0"];
                                                        NSDictionary *oneDic = array[0];
                                                        //获取daily_forecast键所对应的键值
                                                        NSArray *array2 = oneDic[@"daily_forecast"];
                                                        //拿到7天的天气信息,并且转为模型数组
                                                        for (NSDictionary *listDic in array2) {
                                                            WeatherModel *model = [WeatherModel weatherModelWithDic:listDic];
                                                            NSLog(@"%@", model.sc);
                                                            [self.dataArrayWeather addObject:model];
                                                        }
//                                                        NSLog(@"self.dataArrayWeather.count--%ld", self.dataArrayWeather.count);
                                                        
                                                    }
                                                }];
    [dataTask resume];
    
}


- (void)initMapView
{
    
    _mapView = [[MAMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _mapView.delegate = self;
    //开始定位
    _mapView.showsUserLocation = YES;
    //
    _mapView.userTrackingMode = 2;
    
//    [self.view addSubview:_mapView];
}


- (void)initSearch
{
    _search = [[AMapSearchAPI alloc]init];
    
    _search.delegate = self;
    
}

//逆地理编码
- (void)reGeoAction
{
    if (_currentLocation)
    {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        
        [_search AMapReGoecodeSearch:request];
    }
}


#pragma mark AMapSearchDelegate代理方法
/**
 *  当请求发生错误时，会调用代理的此方法.
 *
 *  @param request 发生错误的请求.
 *  @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"error:%@", error);
}
/**
 *  逆地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapReGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapReGeocodeSearchResponse 。
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSLog(@"response :%@", response);
    
    NSString *title = response.regeocode.addressComponent.city;
    if (title.length == 0)
    {
        title = response.regeocode.addressComponent.province;
    }
    
    _mapView.userLocation.title = title;
    
    
    _cytyChs = title;
    
    NSMutableString *strM = [NSMutableString stringWithString:title];
    
    
    
    
    [strM deleteCharactersInRange:NSMakeRange(strM.length - 1, 1)];
    
    
 
    
    if (_city == [ZYChinaseToEng chinaseToEng:strM]) {
        
    } else if (_city == nil){
        NSLog(@"demo");
       [self requestWeatherDataByCityId2:[ZYChinaseToEng chinaseToEng:strM]];
    }
    
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MAMapViewDelegate代理方法
//取出当前定位经纬度
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation) {
        //取出当前位置的坐标
        _currentLocation = [userLocation.location copy];
        mapView.showsUserLocation = NO;
        [self reGeoAction];
    }
}

- (void)requestWeatherDataByCityId2:(NSString *)cityname
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"afdbab51770242bf4d4c4b2effa1d9ed" forHTTPHeaderField:@"apix-key"];
    
    
    [manager GET:[NSString stringWithFormat:@"http://a.apix.cn/heweather/x3/free/weather?city=%@", cityname] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        /**
         *  basic
         */
        NSArray *array = responseObject[@"HeWeather data service 3.0"];
        NSDictionary *oneDic = array[0];
        //获取daily_forecast键所对应的键值
        NSArray *array2 = oneDic[@"daily_forecast"];
        [self.dataArrayWeather removeAllObjects];
        for (NSDictionary *listDic in array2) {
        
            WeatherModel *model = [WeatherModel weatherModelWithDic:listDic];
//            NSLog(@"%@", model.sc);
            [self.dataArrayWeather addObject:model];
        }
//        NSLog(@"self.dataArrayWeather.count--%ld", self.dataArrayWeather.count);
        
        [self.wetherColleView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


#pragma mark -数据源协议方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"self.dataArrayWeather.count--%ld", section);
    return _dataArrayWeather.count - 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.item == 0) {
        static NSString *identifier = @"Cell";
        
        MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        
        
        WeatherModel *model = self.dataArrayWeather[indexPath.item];
//        NSLog(@"%@", model.txt_d);
        cell.cityLabel.text = _cytyChs;
        cell.model = model;
        return cell;
    } else {
        static NSString *identifier = @"cellId";
        
        WeatherHeaderListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        WeatherModel *model = self.dataArrayWeather[indexPath.item];
//        NSLog(@"%@", model.txt_d);
        cell.model = model;
        return cell;
    }
    
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.item == 0) {
        return CGSizeMake(100, 175);
    } else {
        return CGSizeMake(50, 175);
    }
    
}







@end
