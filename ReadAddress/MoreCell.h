//
//  MoreCell.h
//  ReadAddress
//
//  Created by admin on 17/5/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

/*! 设置内容 */
-(void)setCellWithData:(NSArray *)contents;
/*! 设置标题 */
-(void)setCellWithTitle:(NSString *)titles;
@end
