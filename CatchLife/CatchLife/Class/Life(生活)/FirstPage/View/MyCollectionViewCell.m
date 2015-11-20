//
//  MyCollectionViewCell.m
//  HFWeather
//
//  Created by iMAC on 15/11/12.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(WeatherModel *)model
{
    _model = model;
    
    self.code_dImgView.image = [UIImage imageNamed:model.code_d];
    self.code_ImgView.image = [UIImage imageNamed:model.code_n];
    
    self.tmpLabel.text = [NSString stringWithFormat:@"%@~%@℃", model.min,model.max];
    self.txt_d_n_label.text = [NSString stringWithFormat:@"%@~%@",model.txt_d, model.txt_n];
    self.wind_sc_label.text = model.sc;
    
    
    
    
}
@end
