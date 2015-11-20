//
//  DetailController.h
//  CatchLife
//
//  Created by iMAC on 15/11/20.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//


#import "ZYDetailTabBarBackController.h"

@interface DetailController : ZYDetailTabBarBackController



@property (nonatomic, copy) NSString *url;

-(instancetype)initWithUrl:(NSString *)url;
@end
