//
//  ZZGDropCell.m
//  ReadAddress
//
//  Created by admin on 17/5/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ZZGDropCell.h"

@interface ZZGDropCell()
@property (nonatomic, weak) UILabel * titleLabel;

@end

@implementation ZZGDropCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initIView];
    }
    return self;
}
-(void)initIView {
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:self.contentView.frame];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
   static NSString * ID = @"ID";
    ZZGDropCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZZGDropCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}

-(void)setTitleText:(NSString *)textTitle {
    self.titleLabel.text = textTitle;
}

@end
