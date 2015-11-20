//
//  ZYChinaseToEng.m
//  CatchLife
//
//  Created by iMAC on 15/11/17.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "ZYChinaseToEng.h"
#import "PinYin4Objc.h"


@implementation ZYChinaseToEng



+ (NSString *)chinaseToEng:(NSString *)chinase
{
    NSString *sourceText= chinase;
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    
    return outputPinyin;
}

@end
