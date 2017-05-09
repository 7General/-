//
//  DropDownCell.h
//  ReadAddress
//
//  Created by admin on 17/5/8.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^stateSelectClik)(UIButton * statButton);

@interface DropDownCell : UITableViewCell
@property (nonatomic, weak) UIButton *stateButton;

+(instancetype)cellWithTableView:(UITableView *)tableview;
@property (nonatomic, copy) stateSelectClik stateBlock;
-(void)setStateBlock:(stateSelectClik)stateBlock;
-(void)setCellTitles:(NSString *)titles;

-(void)setCellState:(NSString *)states;
@end
