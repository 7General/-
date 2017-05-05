//
//  ZZGSheetRight.h
//  ReadAddress
//
//  Created by admin on 17/5/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZGSheetRight;

@protocol ZZGSheetRightDelegate <NSObject>

@optional
-(void)sheetView:(ZZGSheetRight *)sheetView didSelectString:(NSString *)item;

@end


@interface ZZGSheetRight : UIView
/**
 *  内容视图
 */
@property (nonatomic, strong) UIView *contentView;
/**
 *  行高度
 */
@property (nonatomic, assign) CGFloat rowH;

/**
 *  内容视图的位移X方向
 */
@property (nonatomic, assign) CGFloat contentOffectX;
/**
 *  动画持续时间
 */
@property (nonatomic, assign) CGFloat animationTime;
/**
 * tableView的宽度
 */
@property (nonatomic, assign) CGFloat tableViewW;

@property (nonatomic, weak) id <ZZGSheetRightDelegate> SheetRigthDelegate ;
/**
 *  展示popView
 *
 *  @param array button的title数组
 */
- (void)showSheetViewWithArray:(NSMutableArray *)array;
/**
 *  移除popView
 */
- (void)dismissTheSheetView;



@end
