//
//  MyBase.m
//  CatchLife
//
//  Created by iMAC on 15/11/15.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "MyBase.h"

@implementation MyBase

/**
 *  自定义封装label
 */
+ (UILabel *)baseCreateLabelFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textClolor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = textClolor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = textAlignment;
    return label;
}

+ (UIImageView *)baseCreateImageViewFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}


+  (UIButton *)baseCreateButtonFrame:(CGRect)frame imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
