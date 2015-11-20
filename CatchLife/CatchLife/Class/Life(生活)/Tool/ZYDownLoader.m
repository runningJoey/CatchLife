//
//  ZYDownLoader.m
//  JuHeDemo
//
//  Created by iMAC on 15/11/13.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "ZYDownLoader.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
static ZYDownLoader *downloader = nil;

@implementation ZYDownLoader


+ (instancetype)downloader
{
    return [[self alloc]init];
}


- (void)downloadWithApipath:(NSString *)path api_id:(NSString *)api_id method:(NSString *)method param:(NSDictionary *)param finishBlock:(void(^)(id data))finishBlock failBlock:(void(^)(NSError *error))failBlock
{
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH424aa698c686e5169f55c0c0b9abbc70"];

    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    [juheapi executeWorkWithAPI:path APIID:api_id Parameters:param Method:method Success:^(id responseObject){
        if ([[param objectForKey:@"dtype"] isEqualToString:@"xml"]) {
            NSLog(@"***xml*** \n %@",responseObject);
        }else{
            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
            if (!error_code) {
                finishBlock(responseObject);
                
            }else{
                NSLog(@"%@", responseObject[@"reason"]);
            }
        }
    } Failure:^(NSError *error) {
        NSLog(@"error:%@",error.description);
        
    }];
}


@end
