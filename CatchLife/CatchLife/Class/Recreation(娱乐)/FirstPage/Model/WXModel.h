//
//  WXModel.h
//  CatchLife
//
//  Created by iMAC on 15/11/19.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WXModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*source;
@property (nonatomic, copy) NSString <Optional>*firstImg;
@property (nonatomic, copy) NSString <Optional>*url;

@end
