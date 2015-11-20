//
//  BaseViewController.h
//  CatchLife
//
//  Created by iMAC on 15/11/15.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    UIView *_navigationBar;
}

- (void)addNavLabelFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)fontSize isCenter:(BOOL)isCenter;

- (void)addNavImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

- (void)addNavBtnFrame:(CGRect)frame imageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName text:(NSString *)text target:(id)target action:(SEL)action;


@end
