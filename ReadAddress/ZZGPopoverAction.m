//
//  ZZGPopoverAction.m
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ZZGPopoverAction.h"

@interface ZZGPopoverAction()
/*! 图标 */
@property (nonatomic, strong, readwrite) UIImage *image; ///< 图标
/*! 标题 */
@property (nonatomic, copy, readwrite) NSString *title; ///< 标题


@end

@implementation ZZGPopoverAction



+(instancetype)actionWithTitle:(NSString *)title forimage:(UIImage *)image {
    ZZGPopoverAction * action = [[self alloc] init];
    action.image = image;
    action.title = title ? : @"";
    return action;
}


@end
