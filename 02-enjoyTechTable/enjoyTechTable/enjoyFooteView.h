//
//  enjoyFooteView.h
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewControllerDelegate.h"

@interface enjoyFooteView : UIView



/**
 *  在新添加的xib文件中添加的uiview 如果不这是 size  inspector 设置为frame rectangle
 */


/**
 *  快速创建一个footview对象
 *
 *  @return <#return value description#>
 */
+ (instancetype)footerView;



/**
 *  拥有代理
 */
@property(nonatomic,weak)id<mainViewControllerDelegate> delegate;




@end
