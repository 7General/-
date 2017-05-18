//
//  enjoysCell.h
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "enjoys.h"
#import "enjoyFrame.h"

@interface enjoysCell : UITableViewCell

/**
 *  姓名
 */
@property(nonatomic,retain)UILabel *names;

/**
 *  介绍
 */
@property(nonatomic,retain)UILabel *text;

/**
 *  头像
 */
@property(nonatomic,retain)UIImageView *icon;
/**
 *  球衣号码
 */
@property(nonatomic,retain)UILabel *numbers;
/**
 *  是否服役
 */
@property(nonatomic,retain)UILabel *states;

/**
 *  传入模型数据
 */
//@property(nonatomic,retain)enjoys *enjoy;

/**
 *  传入frmae模型数据
 */
@property(nonatomic,retain)enjoyFrame *enjoyF;

/**
 *  加载cell
 */
+ (instancetype)cellWtihTableView:(UITableView *)tableView;



@end
