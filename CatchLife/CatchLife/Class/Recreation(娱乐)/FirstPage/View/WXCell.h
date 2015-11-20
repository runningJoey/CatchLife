//
//  WXCell.h
//  CatchLife
//
//  Created by iMAC on 15/11/19.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXModel.h"

@interface WXCell : UICollectionViewCell

/**
 *  @property (nonatomic, copy) NSString <Optional>*title;
 @property (nonatomic, copy) NSString <Optional>*source;
 @property (nonatomic, copy) NSString <Optional>*firstImg;
 @property (nonatomic, copy) NSString <Optional>*url;
 */

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;

@property (strong, nonatomic) WXModel *model;


@end
