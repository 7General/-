//
//  ZZGDropCell.h
//  ReadAddress
//
//  Created by admin on 17/5/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZGDropCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

-(void)setTitleText:(NSString *)textTitle;
@end
