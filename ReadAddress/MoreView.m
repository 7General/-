//
//  MoreView.m
//  ReadAddress
//
//  Created by admin on 17/5/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#define DDMWIDTH [UIScreen mainScreen].bounds.size.width
#define DDMHEIGHT [UIScreen mainScreen].bounds.size.height
#define DDMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "MoreView.h"
#import "UIButton+FillColor.h"


NSString *const TheLastSelectArry = @"LASTSEL";

@interface MoreView()
/*! 内容容器 */
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSDictionary *moreDict;
@property (nonatomic, strong) NSMutableArray *titleData;
@property (nonatomic, strong) NSMutableArray * selectArry;

//@property (nonatomic, strong) UIButton *  selectButton;
@end

@implementation MoreView
#pragma mark - lazy
-(NSMutableArray *)selectArry {
    if (_selectArry == nil) {
        _selectArry = [NSMutableArray array];
    }
    return _selectArry;
}

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
    UIScrollView * contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DDMWIDTH, self.frame.size.height)];
    contentScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    
    UIButton * clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(10, 100, 60, 30);
    clearBtn.backgroundColor = [UIColor redColor];
    [clearBtn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clearBtn];
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(10, 180, 60, 30);
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
}
/*! 清空 */
-(void)clearClick {
    NSLog(@"clear");
    [self.selectArry removeAllObjects];
    NSUserDefaults * defaules = [NSUserDefaults standardUserDefaults];
    [defaules setObject:self.selectArry forKey:TheLastSelectArry];
    
    for (UIView * items in self.contentScrollView.subviews) {
        if ([items isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton *)items;
            btn.selected = NO;
        }
    }
}
/*! 确认 */
-(void)sureClick {
    NSLog(@"sure");
    NSLog(@"----->>>>>%@",self.selectArry);
    /*! 持久化处理 */
    NSUserDefaults * defaules = [NSUserDefaults standardUserDefaults];
    [defaules setObject:self.selectArry forKey:TheLastSelectArry];
    
    [self removeFromSuperview];
}

-(void)dractContentView {
    CGFloat titleY = 5;
    CGFloat lastMaxY = 0;
    
    NSArray * lastSelectArys = [[NSUserDefaults standardUserDefaults] objectForKey:TheLastSelectArry];
    [self.selectArry addObjectsFromArray:lastSelectArys];
    
    for (NSInteger row = 0; row < self.titleData.count; row++) {
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, titleY + lastMaxY, 100, 44);
        titleLabel.textColor = [UIColor redColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.text = self.titleData[row];
        [self.contentScrollView addSubview:titleLabel];
    
        CGFloat basicHeight = CGRectGetMaxY(titleLabel.frame);
        NSArray * contentAry = self.moreDict[titleLabel.text];
        //总列数
        int totalColumns = 4;
        //view尺寸
        CGFloat appW = 45;
        CGFloat appH = 30;
        
        //横向间隙 (控制器view的宽度 － 列数＊应用宽度)/(列数 ＋ 1)
        CGFloat margin = (self.frame.size.width - (totalColumns * appW)) / (totalColumns + 1);
        
        if (contentAry.count == 0) {
            lastMaxY = lastMaxY + 30;
            continue;
        }
        
        for (int index = 0; index < contentAry.count; index++) {
            //创建一个小框框//
            NSString * buttonTitle = contentAry[index];
            UIButton * selectButton = [[UIButton alloc] init];
            [selectButton setTitle:buttonTitle forState:UIControlStateNormal];
            [selectButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateNormal];
            [selectButton setBackgroundColor:[UIColor blueColor] forState:UIControlStateSelected];
            selectButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            [selectButton addTarget:self action:@selector(itemSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            //行号
            int row = index / totalColumns; //行号为框框的序号对列数取商
            //列号
            int col = index % totalColumns; //列号为框框的序号对列数取余
            // 每个框框靠左边的宽度为 (平均间隔＋框框自己的宽度）
            CGFloat appX = margin + col * (appW + margin);
            // 每个框框靠上面的高度为 平均间隔＋框框自己的高度
            CGFloat appY = basicHeight + row * (appH + 5);
            selectButton.frame = CGRectMake(appX, appY, appW, appH);
            
            [self.contentScrollView addSubview:selectButton];
            
            lastMaxY = CGRectGetMaxY(selectButton.frame) + 10;
            if ([lastSelectArys containsObject:buttonTitle]) {
                selectButton.selected = YES;
            }
        }
        UIView * lineView  =[[UIView alloc] initWithFrame:CGRectMake(0, lastMaxY + 6, DDMWIDTH, 1)];
        lineView.backgroundColor = [UIColor redColor];
        [self.contentScrollView addSubview:lineView];
    }
    self.contentScrollView.contentSize = CGSizeMake(0, lastMaxY);
}
/*! 单个item点击效果 */
-(void)itemSelectClick:(UIButton *)button {
    button.selected = !button.selected;
    NSString * text = button.titleLabel.text;
    if (button.selected) {
        [self.selectArry addObject:text];
    }else {
        [self.selectArry removeObject:text];
    }
    /*! 持久化处理 */
    NSUserDefaults * defaules = [NSUserDefaults standardUserDefaults];
    [defaules setObject:self.selectArry forKey:TheLastSelectArry];
}

@end
