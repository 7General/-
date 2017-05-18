//
//  enjoyFrame.h
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "enjoys.h"
@interface enjoyFrame : NSObject




/**
 *  姓名
 */
@property(nonatomic,assign,readonly)CGRect nameFrame;

/**
 *  介绍
 */
@property(nonatomic,assign,readonly)CGRect textFrame;

/**
 *  头像
 */
@property(nonatomic,assign,readonly)CGRect iconFrame;
/**
 *  球衣号码
 */
@property(nonatomic,assign,readonly)CGRect numbersFrame;
/**
 *  是否服役  注意此处不要添加"*" bool类型是yes 和no   就是 1  和 0
 */
@property(nonatomic,assign,readonly)CGRect statesFrame;

/**
 *  行高
 */
@property(nonatomic,assign,readonly)CGFloat cellHeight;


@property(nonatomic,retain)enjoys *enjoy;





@end
