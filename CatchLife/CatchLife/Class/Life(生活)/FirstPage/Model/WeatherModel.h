//
//  WeatherModel.h
//  HFWeather
//
//  Created by iMAC on 15/11/10.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "JSONModel.h"

@interface WeatherModel : JSONModel

//"daily_forecast": [{
//    "astro": {
//        "sr": "06:53",
//        "ss": "17:03"
//    },
//    "cond": {
//        "code_d": "502",
//        "code_n": "501",
//        "txt_d": "霾",
//        "txt_n": "雾"
//    },
//    "date": "2015-11-10",
//    "hum": "75",
//    "pcpn": "0.1",
//    "pop": "27",
//    "pres": "1028",
//    "tmp": {
//        "max": "8",
//        "min": "4"
//    },
//    "vis": "10",
//    "wind": {
//        "c": "129",
//        "dir": "无持续风向",
//        "sc": "微风",
//        "spd": "7"
//    }
//},



/**
 *  basic": {
 "city": "北京",
 "cnty": "中国",
 "id": "CN101010100",
 "lat": "39.904000",
 "lon": "116.391000",
 "update": {
 "loc": "2015-11-12 21:53",
 "utc": "2015-11-12 13:53"
 }
 },
 "
 */

@property (nonatomic, copy) NSString <Optional>*sr;
@property (nonatomic, copy) NSString <Optional>*ss;

@property (nonatomic, copy) NSString <Optional>*code_d;
@property (nonatomic, copy) NSString <Optional>*code_n;
@property (nonatomic, copy) NSString <Optional>*txt_d;
@property (nonatomic, copy) NSString <Optional>*txt_n;

@property (nonatomic, copy) NSString <Optional>*date;
@property (nonatomic, copy) NSString <Optional>*hum;
@property (nonatomic, copy) NSString <Optional>*pcpn;
@property (nonatomic, copy) NSString <Optional>*pop;
@property (nonatomic, copy) NSString <Optional>*pres;


@property (nonatomic, copy) NSString <Optional>*max;
@property (nonatomic, copy) NSString <Optional>*min;

@property (nonatomic, copy) NSString <Optional>*vis;

@property (nonatomic, copy) NSString <Optional>*deg;
@property (nonatomic, copy) NSString <Optional>*sc;
@property (nonatomic, copy) NSString <Optional>*dir;
@property (nonatomic, copy) NSString <Optional>*spd;


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (WeatherModel *)weatherModelWithDic:(NSDictionary *)dic;

@end
