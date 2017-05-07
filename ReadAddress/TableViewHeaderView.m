//
//  TableViewHeaderView.m
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TableViewHeaderView.h"

@implementation TableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];//rgba(240, 240, 240, 0.8);
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 20)];
        self.name.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.name];
    }
    return self;
}


@end
