//
//  requeCell.h
//  ReadAddress
//
//  Created by ZZG on 17/5/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface requeCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)tableview;


-(void)initView:(NSArray *)titleData;
@end
