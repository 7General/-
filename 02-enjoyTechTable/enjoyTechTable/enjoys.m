//
//  enjoys.m
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "enjoys.h"

@implementation enjoys


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        /**
         *  注意此处
         该类属性的名字 一定要和plist文件的内容一样 否则找不到数据
         */
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}
+ (instancetype)enjoysWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}




@end
