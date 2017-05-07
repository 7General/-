//
//  CategoryModel.m
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CategoryModel.h"


@implementation CategoryModel

+ (NSDictionary *)objectClassInArray
{
    return @{ @"spus": @"rightTableModel" };
}

@end

@implementation rightTableModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"foodId": @"id" };
}

@end
