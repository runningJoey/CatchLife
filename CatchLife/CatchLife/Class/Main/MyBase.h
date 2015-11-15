//
//  MyBase.h
//  CatchLife
//
//  Created by iMAC on 15/11/15.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyBase : NSObject


+ (UILabel *)baseCreateLabelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textClolor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;

+ (UIImageView *)baseCreateImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

+  (UIButton *)baseCreateButtonFrame:(CGRect)frame imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action;
@end
