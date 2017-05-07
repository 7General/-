//
//  RightTableViewCell.h
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class rightTableModel;

#define kCellIdentifier_Right @"RightTableViewCell"

@interface RightTableViewCell : UITableViewCell

@property (nonatomic, strong) rightTableModel *model;

@end
