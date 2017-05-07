//
//  ZZGPopoverAction.h
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,PopoverViewStyle) {
    PopoverViewStyleDefault = 0, // 默认风格, 白色
    PopoverViewStyleDark, // 黑色风格
};


@interface ZZGPopoverAction : NSObject

///< 图标 (建议使用 60pix*60pix 的图片)
@property (nonatomic, strong, readonly) UIImage * image;
@property (nonatomic, copy, readonly) NSString * title;


+(instancetype)actionWithTitle:(NSString *)title forimage:(UIImage *)image;


@end
