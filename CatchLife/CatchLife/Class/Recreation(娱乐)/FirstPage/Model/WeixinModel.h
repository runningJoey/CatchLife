//
//  WeixinModel.h
//  CatchLife
//
//  Created by iMAC on 15/11/19.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface LitModel : JSONModel
/**
 *  {
 "id": "wechat_20150401071581",
 "title": "号外：集宁到乌兰花的班车出事了！！！！！",
 "source": "内蒙那点事儿",
 "firstImg": "http://zxpic.gtimg.com/infonew/0/wechat_pics_-214279.jpg/168",
 "mark": "",
 "url": "http://v.juhe.cn/weixin/redirect?wid=wechat_20150401071581"
 },
 */

@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*source;
@property (nonatomic, copy) NSString <Optional>*firstImg;
@property (nonatomic, copy) NSString <Optional>*url;


@end



@protocol LitModel;
@interface ListModel : JSONModel
/**
 *    "totalPage": 16,
 "ps": 20,
 "pno": 1
 */
@property (strong, nonatomic) NSArray <LitModel>*list;

@property (nonatomic, strong) NSNumber <Optional>*totalPage;
@property (nonatomic, strong) NSNumber <Optional>*ps;
@property (nonatomic, strong) NSNumber <Optional>*pno;


@end

@protocol ListModel;
@interface WeixinModel : JSONModel
/**
 *  {
 "reason": "success",
 "result": {
 "list": [
 {
 "id": "wechat_20150401071581",
 "title": "号外：集宁到乌兰花的班车出事了！！！！！",
 "source": "内蒙那点事儿",
 "firstImg": "http://zxpic.gtimg.com/infonew/0/wechat_pics_-214279.jpg/168",
 "mark": "",
 "url": "http://v.juhe.cn/weixin/redirect?wid=wechat_20150401071581"
 },
 */
@property (nonatomic, copy) NSString <Optional>*reason;

@property (strong, nonatomic) LitModel *result;

@property (nonatomic, strong) NSNumber <Optional>*error_code;




@end
