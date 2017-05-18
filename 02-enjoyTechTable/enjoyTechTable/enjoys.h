//
//  enjoys.h
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface enjoys : NSObject




/**
 *  姓名
 */
@property(nonatomic,retain)NSString *name;

/**
 *  介绍
 */
@property(nonatomic,retain)NSString *text;

/**
 *  头像
 */
@property(nonatomic,retain)NSString *icon;
/**
 *  球衣号码
 */
@property(nonatomic,retain)NSString *numbers;
/**
 *  是否服役  注意此处不要添加"*" bool类型是yes 和no   就是 1  和 0
 */
@property(nonatomic,assign)BOOL states;




- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)enjoysWithDict:(NSDictionary *)dict;

@end
