//
//  WeatherHeaderListCell.h
//  HFWeather
//
//  Created by iMAC on 15/11/10.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface WeatherHeaderListCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *code_dImgView;
@property (weak, nonatomic) IBOutlet UIImageView *code_ImgView;

@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;

@property (weak, nonatomic) IBOutlet UILabel *txt_d_n_label;

@property (weak, nonatomic) IBOutlet UILabel *wind_sc_label;

@property (strong, nonatomic) WeatherModel *model;

@end
