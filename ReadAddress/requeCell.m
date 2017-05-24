//
//  requeCell.m
//  ReadAddress
//
//  Created by ZZG on 17/5/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#define DDMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "requeCell.h"

@implementation requeCell

+(instancetype)cellWithTable:(UITableView *)tableview {
    static NSString * ID = @"ID";
    requeCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[requeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    } else {
        // 当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    return cell;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)initView:(NSArray *)titleData {
    
    //总列数
    int totalColumns = 3;
    //view尺寸
    CGFloat appW = 95;
    CGFloat appH = 30;
    
    //横向间隙 (控制器view的宽度 － 列数＊应用宽度)/(列数 ＋ 1)
    CGFloat margin = (self.frame.size.width - (totalColumns * appW)) / (totalColumns + 1);
    
    
    for (int index = 0; index < titleData.count; index++) {
        //创建一个小框框//
        NSString * buttonTitle = titleData[index];
        UIButton * selectButton = [[UIButton alloc] init];
        selectButton.titleLabel.font = [UIFont systemFontOfSize:14];
        selectButton.layer.cornerRadius = 15;
        selectButton.layer.masksToBounds = YES;
        selectButton.layer.borderWidth = 1;
        
        selectButton.layer.borderColor = DDMColor(237, 237, 237).CGColor;
        [selectButton setTitle:buttonTitle forState:UIControlStateNormal];
        //[selectButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [selectButton setTitleColor:DDMColor(125, 125, 125) forState:UIControlStateNormal];
        
        //[selectButton setBackgroundColor:DDMColor(47, 150, 255) forState:UIControlStateSelected];
        [selectButton setTitleColor:DDMColor(255, 255, 255) forState:UIControlStateSelected];
        
        selectButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        //[selectButton addTarget:self action:@selector(itemSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        //行号
        int row = index / totalColumns; //行号为框框的序号对列数取商
        //列号
        int col = index % totalColumns; //列号为框框的序号对列数取余
        // 每个框框靠左边的宽度为 (平均间隔＋框框自己的宽度）
        CGFloat appX = margin + col * (appW + margin);
        // 每个框框靠上面的高度为 平均间隔＋框框自己的高度
        CGFloat appY = 10 + row * (appH + 5);
        selectButton.frame = CGRectMake(appX, appY, appW, appH);
        
        [self.contentView addSubview:selectButton];

    }
}


@end
