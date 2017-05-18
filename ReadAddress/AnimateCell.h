//
//  AnimateCell.h
//  ReadAddress
//
//  Created by hzbj on 17/5/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AnimateCellDelegate <NSObject>

-(void)animateCellHeightCustom:(NSIndexPath *)path;
-(void)consoleCellSelectIndex:(NSInteger )selectTag didselectIndexPath:(NSIndexPath *)path;

@end

@interface AnimateCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSIndexPath * pathIndex;

@property (nonatomic, weak) id<AnimateCellDelegate> delegate;

-(void)setcellWithTitle:(NSString *)titles;
-(void)setHiddenConsoleView;
-(void)setShowConsoleView;
@end
