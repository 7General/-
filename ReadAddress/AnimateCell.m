//
//  AnimateCell.m
//  ReadAddress
//
//  Created by hzbj on 17/5/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AnimateCell.h"

@interface AnimateCell()
@property (nonatomic, strong) UIButton *addCell;
@property (nonatomic, weak) UIView *consoleView;
@end

@implementation AnimateCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.layer.masksToBounds = YES;
        self.addCell = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addCell.frame = CGRectMake(0, 0, 50, 40);
        self.addCell.backgroundColor = [UIColor redColor];
        [self.addCell addTarget:self action:@selector(addCellClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addCell];
        
        
        UIView *consoleView = [[UIView alloc] initWithFrame:CGRectMake(0, -50, 300, 50)];
        consoleView.backgroundColor = [UIColor redColor];
        consoleView.hidden = YES;
        [self.contentView addSubview:consoleView];
        self.consoleView = consoleView;
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 30, 100, 20);
        btn.tag = 9000;
        btn.backgroundColor = [UIColor yellowColor];
        [btn addTarget:self action:@selector(sheetClick:) forControlEvents:UIControlEventTouchUpInside];
        [consoleView addSubview:btn];
        
    }
    return self;
}
-(void)setHiddenConsoleView {
    
    self.consoleView.hidden = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.consoleView.transform = CGAffineTransformMakeTranslation(0, -50);
        
    }completion:^(BOOL finished) {
       
        [UIView animateWithDuration:0.25 delay:0.7 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            self.consoleView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}
-(void)setShowConsoleView {
    self.consoleView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.consoleView.transform = CGAffineTransformMakeTranslation(0, 50);
    }];
}


-(void)setPathIndex:(NSIndexPath *)pathIndex {
    _pathIndex = pathIndex;
}
-(void)setcellWithTitle:(NSString *)titles {
    [self.addCell setTitle:titles forState:UIControlStateNormal];
}

/**
 出现动画 显示操作台
 */
-(void)addCellClick {
    [self.delegate animateCellHeightCustom:self.pathIndex];
}
-(void)sheetClick:(UIButton *)sender {
    [self setHiddenConsoleView];
    [self.delegate consoleCellSelectIndex:sender.tag didselectIndexPath:self.pathIndex];
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"ID";
    AnimateCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[AnimateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


@end
