//
//  LeftTableViewCell.m
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LeftTableViewCell.h"

#define defaultColor rgb(253, 212, 49)

@interface LeftTableViewCell ()

@property (nonatomic, strong) UIView *yellowView;

@end

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
        self.name.numberOfLines = 0;
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textColor = [UIColor redColor];//rgba(130, 130, 130, 1);
        self.name.highlightedTextColor = [UIColor greenColor];
        [self.contentView addSubview:self.name];
        
        self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 45)];
        self.yellowView.backgroundColor = [UIColor redColor];//defaultColor;
        [self.contentView addSubview:self.yellowView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.name.highlighted = selected;
    self.yellowView.hidden = !selected;
}
@end
