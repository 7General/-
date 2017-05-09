//
//  MoreView.m
//  ReadAddress
//
//  Created by admin on 17/5/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#define DDMWIDTH [UIScreen mainScreen].bounds.size.width
#define DDMHEIGHT [UIScreen mainScreen].bounds.size.height

#import "MoreView.h"
#import "MoreCell.h"

@interface MoreView()
/*! 内容容器 */
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSDictionary *moreDict;
@property (nonatomic, strong) NSMutableArray *titleData;

@end

@implementation MoreView
#pragma mark - lazy
-(NSMutableArray *)titleData {
    if (_titleData == nil) {
        _titleData = [NSMutableArray array];
    }
    return _titleData;
}
-(NSDictionary *)moreDict {
    if (_moreDict == nil) {
        _moreDict = [NSDictionary dictionary];
    }
    return _moreDict;
}
-(void)initMoreDataContent {
    NSArray * mjd = @[@"95",@"103",@"115",@"117",@"125",@"130",@"167",@"180",@"230",@"2000以上"].mutableCopy;
    NSArray * mj = @[].mutableCopy;
    NSArray * js = @[@"1居",@"2居",@"3居",@"4居",@"5居"].mutableCopy;
    NSArray * cx = @[@"东向",@"东西",@"北向",@"南北",@"南向",@"西向"].mutableCopy;
    NSArray * zx = @[@"精装",@"毛坯"].mutableCopy;
    NSArray * gjsj = @[@"3天内",@"4-7天",@"8-14天",@"15天以上"].mutableCopy;
    NSArray * ewm = @[@"是",@"否"].mutableCopy;
    NSArray * yy = @[@"邀约客户"].mutableCopy;
    self.moreDict = @{
                      @"面积段(平方米)":mjd,
                      @"面积(平方米)":mj,
                      @"居室":js,
                      @"朝向":cx,
                      @"装修":zx,
                      @"最近一次跟进时间":gjsj,
                      @"是否有二维码":ewm,
                      @"邀约":yy
                      };
    self.titleData = @[
                       @"面积段(平方米)",
                       @"面积(平方米)",
                       @"居室",
                       @"朝向",
                       @"装修",
                       @"最近一次跟进时间",
                       @"是否有二维码",
                       @"邀约"
                       ].mutableCopy;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self initMoreDataContent];
        [self dractContentView];
    }
    return self;
}
-(void)initView {
    UIScrollView * contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DDMWIDTH, 100)];
    contentScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
}
-(void)dractContentView {
    CGFloat titleY = 5;
    CGFloat maxW = DDMWIDTH - 20;
    //self.titleData.count
    for (NSInteger row = 0; row < 1; row++) {
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, titleY, 100, 44);
        titleLabel.textColor = [UIColor redColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.text = self.titleData[row];
        [self.contentScrollView addSubview:titleLabel];
        
        NSArray * contentAry = self.moreDict[titleLabel.text];
        for (NSInteger column = 0; column < contentAry.count; column++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(10, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        }
    }
     
    
    
    /*! 画标题 */
    return;
//    CGFloat maxW = DDMWIDTH - 20;
//    [self.titleData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UILabel * titleLabel = [[UILabel alloc] init];
//        titleLabel.frame = CGRectMake(10, titleY, 100, 44);
//        titleLabel.textColor = [UIColor blackColor];
//        titleLabel.font = [UIFont systemFontOfSize:13];
//        titleLabel.text = self.titleData[idx];
//        
//        NSLog(@"----%@",titleLabel.text);
//        titleLabel.backgroundColor = [UIColor redColor];
//        [self.contentScrollView addSubview:titleLabel];
//        
//        NSArray * content = self.moreDict[titleLabel.text];
//        
//        [content enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(idx * 60, CGRectGetMaxY(titleLabel.frame), 60, 44);
//            [btn setTitle:(NSString *)obj forState:UIControlStateNormal];
//            btn.backgroundColor = [UIColor blackColor];
//            [self.contentScrollView addSubview:btn];
//        }];
//        
//    }];



}

@end
