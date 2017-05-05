//
//  RightToleftController.m
//  ReadAddress
//
//  Created by admin on 17/5/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "RightToleftController.h"
#import "ZZGSheetRight.h"

@interface RightToleftController ()<ZZGSheetRightDelegate>
@property (nonatomic, strong) ZZGSheetRight * SheetRight;

@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation RightToleftController


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
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(10, 170, 100, 40);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"sheet从右向左" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(sheetFromRight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}
-(void)sheetFromRight {
    self.SheetRight = [[ZZGSheetRight alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.SheetRight.SheetRigthDelegate = self;
    [self.SheetRight showSheetViewWithArray:self.titleArray];
}
-(void)sheetView:(ZZGSheetRight *)sheetView didSelectString:(NSString *)item {
    NSLog(@"---->%@",item);
    [self.SheetRight dismissTheSheetView];

}


@end
