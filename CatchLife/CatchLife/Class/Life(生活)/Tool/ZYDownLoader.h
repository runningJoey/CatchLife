//
//  ZYDownLoader.h
//  JuHeDemo
//
//  Created by iMAC on 15/11/13.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYDownLoader : NSObject



+ (instancetype)downloader;

- (void)downloadWithApipath:(NSString *)path api_id:(NSString *)api_id method:(NSString *)method param:(NSDictionary *)param finishBlock:(void(^)(id data))finishBlock failBlock:(void(^)(NSError *error))failBlock;


@end
