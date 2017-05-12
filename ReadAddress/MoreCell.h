//
//  MoreCell.h
//  ReadAddress
//
//  Created by ZZG on 17/5/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreCellDelegate <NSObject>

-(void)updataCellHeightCustom:(NSIndexPath *)path;

@end

@interface MoreCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSIndexPath * pathIndex;

@property (nonatomic, weak) id<MoreCellDelegate> delegate;

-(void)setcellWithTitle:(NSString *)titles;
-(void)setHiddenConsoleView;
-(void)setShowConsoleView;

@end
