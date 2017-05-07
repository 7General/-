//
//  ZZGPopoverView.h
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZGPopoverAction.h"
#import "PopoverViewCell.h"


@class ZZGPopoverView;
@protocol ZZGPopoverViewDelegate <NSObject>

@optional
-(void)popoverView:(ZZGPopoverView *)popView didSelectIndex:(NSIndexPath *)indexPath;

@end

@interface ZZGPopoverView : UIView
/* 是否开启点击外部隐藏弹窗, 默认为YES. */
@property (nonatomic, assign) BOOL hideAfterTouchOutside;
/* 默认为YES.是否显示阴影, 如果为YES则弹窗背景为半透明的阴影层, 否则为透明, */
@property (nonatomic, assign) BOOL showShade;
/* 弹出窗风格, 默认为 PopoverViewStyleDefault(白色). */
@property (nonatomic, assign) PopoverViewStyle style;

+ (instancetype)popoverView;

/*! @brief 指向指定的View来显示弹窗
 *  @param pointView 箭头指向的View
 *  @param actions   动作对象集合<PopoverAction>
 */
- (void)showToView:(UIView *)pointView withActions:(NSArray<ZZGPopoverAction *> *)actions;

/*! @brief 指向指定的点来显示弹窗
 *  @param toPoint 箭头指向的点(这个点的坐标需按照keyWindow的坐标为参照)
 *  @param actions 动作对象集合<PopoverAction>
 */
- (void)showToPoint:(CGPoint)toPoint withActions:(NSArray<ZZGPopoverAction *> *)actions;

/*! 点击事件代理 */
@property (nonatomic, weak) id<ZZGPopoverViewDelegate> popDelegate;

@end
