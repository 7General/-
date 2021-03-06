//
//  ZZGDropView.m
//  ReadAddress
//
//  Created by admin on 17/5/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ZZGDropView.h"
#import "ZZGDropCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZZGDropView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ZZGDropView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化各种起始属性
        [self initAttribute];
        
        [self initTabelView];
    }
    return self;
}
- (void)initTabelView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.contentShift) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
}

/**
 *  初始化起始属性
 */
- (void)initAttribute {
    self.buttonH = 44;
    self.buttonMargin = 10;
    self.contentShift = SCREEN_HEIGHT * (300.0/736.0);
    self.animationTime = 0.25;
    self.backgroundColor = [UIColor colorWithWhite:0.614 alpha:0.700];
    [self initSubViews];
}
/**
 *  初始化子控件
 */
- (void)initSubViews{
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.contentShift);
    [self addSubview:self.contentView];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissThePopView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZGDropCell * cell = [ZZGDropCell cellWithTableView:tableView];
    NSString * Str = self.dataSource[indexPath.row];
    [cell setTitleText:Str];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.DropViewDelegate && [self.DropViewDelegate respondsToSelector:@selector(dropView:didSelectString:)]) {
        NSString * Str = self.dataSource[indexPath.row];
        [self.DropViewDelegate dropView:self didSelectString:Str];
    }
}

#pragma mark - UITableViewDelagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.buttonH;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)viewDidLayoutSubviews{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)showDropViewWithArray:(NSMutableArray *)array {
    UIWindow * window = [self mainWindow];
    [window addSubview:self];
    
    self.dataSource = array;
    //1.执行动画
    [UIView animateWithDuration:self.animationTime animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentShift);
    }];

}


- (void)dismissThePopView {
    [UIView animateWithDuration:self.animationTime animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


//获取当前window
- (UIWindow *)mainWindow {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

@end
