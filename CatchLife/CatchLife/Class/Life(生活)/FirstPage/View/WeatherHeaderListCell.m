//
//  WeatherHeaderListCell.m
//  HFWeather
//
//  Created by iMAC on 15/11/10.
//  Copyright (c) 2015年 iMAC. All rights reserved.
//

#import "WeatherHeaderListCell.h"

@implementation WeatherHeaderListCell

- (void)awakeFromNib {
    // Initialization code
}

/**
 *  @property (weak, nonatomic) IBOutlet UIImageView *code_dImgView;

 
 @property (weak, nonatomic) IBOutlet UILabel *tmpLabel;
 
 @property (weak, nonatomic) IBOutlet UILabel *txt_d_n_label;
 
 @property (weak, nonatomic) IBOutlet UILabel *wind_sc_label;
 *
 *  @param model
 */

/**
 *  @property (nonatomic, copy) NSString <Optional>*sr;
 @property (nonatomic, copy) NSString <Optional>*ss;
 
 @property (nonatomic, copy) NSString <Optional>*code_d;
 @property (nonatomic, copy) NSString <Optional>*code_n;
 @property (nonatomic, copy) NSString <Optional>*txt_d;
 @property (nonatomic, copy) NSString <Optional>*txt_n;
 
 @property (nonatomic, copy) NSString <Optional>*date;
 @property (nonatomic, copy) NSString <Optional>*hum;
 @property (nonatomic, copy) NSString <Optional>*pcpn;
 @property (nonatomic, copy) NSString <Optional>*pop;
 @property (nonatomic, copy) NSString <Optional>*pres;
 
 @property (nonatomic, copy) NSString <Optional>*max;
 @property (nonatomic, copy) NSString <Optional>*min;
 
 @property (nonatomic, copy) NSString <Optional>*vis;
 
 @property (nonatomic, copy) NSString <Optional>*deg;
 @property (nonatomic, copy) NSString <Optional>*sc;
 @property (nonatomic, copy) NSString <Optional>*dir;
 @property (nonatomic, copy) NSString <Optional>*spd;
 *
 *  @param model
 */
- (void)setModel:(WeatherModel *)model
{
    _model = model;
    self.code_dImgView.image = [UIImage imageNamed:model.code_d];
    self.code_ImgView.image = [UIImage imageNamed:model.code_n];
    
    self.tmpLabel.text = [NSString stringWithFormat:@"%@~%@℃", model.min,model.max];
    self.txt_d_n_label.text = [NSString stringWithFormat:@"%@~%@",model.txt_d, model.txt_n];
    self.wind_sc_label.text = model.sc;
    
    self.weekLabel.text = [self dateToWeek:model.date];
    
    self.dateLabel.text = [self dateToMD:model.date];
    
    self.txt_d_n_label = [NSString stringWithFormat:@"%@~%@", model.txt_d, model.txt_n];
    
}


//分割日期
- (NSString *)dateToMD:(NSString *)dateStr
{
    if (!dateStr) {
        return @"";
    }
    NSArray *array = [dateStr componentsSeparatedByString:@"-"];
    return [NSString stringWithFormat:@"%@月%@日", array[1], array[2]];
}

//处理时间转周几
- (NSString *)dateToWeek:(NSString *)dateStr
{
    
    NSDateFormatter *dateFormater2 = [[NSDateFormatter alloc]init];
    [dateFormater2 setDateFormat:@"YYYY-MM-dd"];//需转换的格式
    
    NSDate *date = [dateFormater2 dateFromString:dateStr];
    
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"EEE"];//需转换的格式
    
    NSString *dateStr2 = [dateFormater stringFromDate:date];

    NSLog(@"%@", dateStr2);
    
    return dateStr2;
}

@end
