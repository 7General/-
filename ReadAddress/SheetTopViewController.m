//
//  SheetTopViewController.m
//  ReadAddress
//
//  Created by admin on 17/5/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "SheetTopViewController.h"
#import "ZZGDropView.h"

@interface SheetTopViewController ()<ZZGDropViewDelegate>
@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) ZZGDropView *dropView;

@end

@implementation SheetTopViewController


//懒加载标题数组
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


- (void)initTitleArray{
    //给此数组传递popView的各项标题
    [self.titleArray addObject:@"测试1"];
    [self.titleArray addObject:@"测试2"];
    [self.titleArray addObject:@"测试3"];
    [self.titleArray addObject:@"测试4"];
    [self.titleArray addObject:@"测试5"];
    [self.titleArray addObject:@"测试6"];
    [self.titleArray addObject:@"测试7"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTitleArray];
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(10, 300, 100, 40);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"popSheetView" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(showSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
}

-(void)showSheet {
    self.dropView = [[ZZGDropView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.dropView.DropViewDelegate = self;
    [self.dropView showDropViewWithArray:self.titleArray];
}
#pragma mark - 点击代理函数
-(void)dropView:(ZZGDropView *)dropView didSelectString:(NSString *)item {
    NSLog(@"---->%@",item);
    [self.dropView dismissThePopView];
}

@end
