//
//  TableViewCell.m
//  FDSlideBarDemo
//
//  Created by fergusding on 15/7/14.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()



@end

@implementation TableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Custom Accessors



@end
