//
//  WXCell.m
//  CatchLife
//
//  Created by iMAC on 15/11/19.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "WXCell.h"
#import <UIImageView+WebCache.h>
@implementation WXCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(WXModel *)model
{
    _model = model;
    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:model.firstImg]];
    self.titleLabel.text = model.title;

}

@end
