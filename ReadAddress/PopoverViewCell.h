//
//  PopoverViewCell.h
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZZGPopoverAction.h"

/*! 水平间距边距 */
UIKIT_EXTERN float const PopoverViewCellHorizontalMargin;
/*! 垂直边距 */
UIKIT_EXTERN float const PopoverViewCellVerticalMargin;
/*! 标题左边边距 */
UIKIT_EXTERN float const PopoverViewCellTitleLeftEdge; 




@interface PopoverViewCell : UITableViewCell


@property (nonatomic, assign) PopoverViewStyle style;

/*! @brief 标题字体
 */
+ (UIFont *)titleFont;

/*! @brief 底部线条颜色
 */
+ (UIColor *)bottomLineColorForStyle:(PopoverViewStyle)style;

- (void)setAction:(ZZGPopoverAction *)action;

- (void)showBottomLine:(BOOL)show;



@end
