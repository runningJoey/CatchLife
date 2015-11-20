//
//  WeatherModel.m
//  HFWeather
//
//  Created by iMAC on 15/11/10.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.sr = dic[@"astro"][@"sr"];
        self.ss = dic[@"astro"][@"ss"];
        
        self.code_d = dic[@"cond"][@"code_d"];
        self.code_d = dic[@"cond"][@"code_n"];
        self.txt_d = dic[@"cond"][@"txt_d"];
        self.txt_n = dic[@"cond"][@"txt_n"];
        
        self.date = dic[@"date"];
        self.hum = dic[@"hum"];
        self.pcpn = dic[@"pcpn"];
        self.pop = dic[@"pop"];
        self.pres = dic[@"pres"];
        
        self.max = dic[@"tmp"][@"max"];
        self.min = dic[@"tmp"][@"min"];
        
        self.vis = dic[@"vis"];
        
        self.deg = dic[@"wind"][@"deg"];
        self.sc = dic[@"wind"][@"sc"];
        self.dir = dic[@"wind"][@"dir"];
        self.spd = dic[@"wind"][@"spd"];
        
    }
    return self;
}

+ (WeatherModel *)weatherModelWithDic:(NSDictionary *)dic
{
    return [[WeatherModel alloc]initWithDic:dic];
}





@end
