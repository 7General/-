//
//  ZZGSheetRight.m
//  ReadAddress
//
//  Created by admin on 17/5/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ZZGSheetRight.h"

@interface ZZGSheetRight()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ZZGSheetRight

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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.contentOffectX, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
}
/**
 *  初始化起始属性
 */
- (void)initAttribute {
    self.rowH = 44;
    self.contentOffectX = 200;
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
    self.contentView.frame = CGRectMake(SCREEN_WIDTH, 0, self.contentOffectX, SCREEN_HEIGHT);
    [self addSubview:self.contentView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissTheSheetView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    ZZGDropCell * cell = [ZZGDropCell cellWithTableView:tableView];
    NSString * Str = self.dataSource[indexPath.row];
    [cell setTitleText:Str];
    return cell;
     */
    static NSString * ID = @"ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.SheetRigthDelegate && [self.SheetRigthDelegate respondsToSelector:@selector(sheetView:didSelectString:)]) {
        NSString * Str = self.dataSource[indexPath.row];
        [self.SheetRigthDelegate sheetView:self didSelectString:Str];
    }
}



- (void)showSheetViewWithArray:(NSMutableArray *)array {
    UIWindow * window = [self mainWindow];
    [window addSubview:self];
    
    self.dataSource = array;
    //1.执行动画
    [UIView animateWithDuration:self.animationTime animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.contentView.transform = CGAffineTransformMakeTranslation(-self.contentOffectX, 0);
    }];
    
}


- (void)dismissTheSheetView {
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
