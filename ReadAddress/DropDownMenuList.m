//
//  DropDownMenuList.m
//  ReadAddress
//
//  Created by admin on 17/5/8.
//  Copyright © 2017年 admin. All rights reserved.
//

#define CurrentWindow [self getCurrentWindowView]
#define DDMWIDTH [UIScreen mainScreen].bounds.size.width
#define DDMHEIGHT [UIScreen mainScreen].bounds.size.height
#define DDMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#import "DropDownMenuList.h"
#import "DropDownCell.h"
#import "MoreView.h"

CGFloat const DropMenuContentHeight = 220.f;
CGFloat const SureButtonHeight = 44.f;

@implementation HZIndexPath

-(instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row {
    if (self == [super init]) {
        self.column = column;
        self.row = row;
    }
    return self;
}
/**
 *  添加构造器
 *
 *  @param column 列
 *  @param row    行
 *
 */
+(instancetype)indexPathWithColumn:(NSInteger)column row:(NSInteger)row {
    return [[self alloc] initWithColumn:column row:row];
}



@end



@interface DropDownMenuList()<UITableViewDelegate,UITableViewDataSource>

// 标题按钮
@property (nonatomic, strong) UIButton * titleButton;

@property (nonatomic, strong) UIView * DropDownMenuView;

@property (nonatomic, weak) UIButton *cover;

// 当前选中的Tag
@property (nonatomic, assign) NSInteger  currrntSelectedColumn;

@property (nonatomic, strong) UITableView * leftTableView;
// 标题高度
@property (nonatomic, assign) NSInteger  titleMenuHeight;
// 标题数组
@property (nonatomic, strong) NSMutableArray * titleMenuArry;
// 当前选中的列
@property (nonatomic, strong) NSMutableArray * currentSelectedRows;
@property (nonatomic, assign) CGFloat animationTime;
@property (nonatomic, strong) NSMutableArray * titles;
/*! 确定按钮 */
@property (nonatomic, strong) UIButton * sureButton;
/*! 记录选中的cell */
@property (nonatomic, strong) NSMutableArray *selectArry;
//########################################
/** 用来显示具体内容的容器 */

@property (nonatomic) CGPoint sorcePoint;
@property (nonatomic) CGSize  viewSize;
/*! 初始化选中状态数组 */
@property (nonatomic, strong) NSMutableArray *selectStateArry;
/*! 标识选中cell的状态 */
@property (nonatomic, strong) NSMutableArray *StateCellArry;
/*! 记录选中的cell的用于发送请求 */
@property (nonatomic, strong) NSMutableArray * cellSelectArry;

/*! 更多view */
@property (nonatomic, strong) MoreView *moreView;
@end

@implementation DropDownMenuList
#pragma mark - lazy


-(NSMutableArray *)selectStateArry {
    if (_selectStateArry == nil) {
        _selectStateArry = [NSMutableArray array];
    }
    return _selectStateArry;
}

-(NSMutableArray *)StateCellArry {
    if (_StateCellArry == nil) {
        _StateCellArry = [NSMutableArray array];
    }
    return _StateCellArry;
}

-(UIView *)DropDownMenuView {
    if (_DropDownMenuView == nil) {
        _DropDownMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height + self.frame.origin.y, DDMWIDTH, 0)];
    }
    return _DropDownMenuView;
}

-(NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray new];
    }
    return _titles;
}

-(NSMutableArray *)cellSelectArry {
    if (_cellSelectArry == nil) {
        _cellSelectArry = [NSMutableArray array];
    }
    return _cellSelectArry;
}



/**
 *  初始化变量
 *
 *  @param origin 原点
 *  @param height 导航栏高度
 *
 */
-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, DDMWIDTH, height)];
    if (self) {
        self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x, 0, DDMWIDTH, 0) style:UITableViewStylePlain];
        self.leftTableView.delegate = self;
        self.leftTableView.dataSource = self;
        self.leftTableView.rowHeight = 44;
        [self.DropDownMenuView addSubview:self.leftTableView];
        self.animationTime = 0.15;
        self.titleMenuHeight = height;
    }
    return self;
}

//##################################
+(instancetype)show:(CGPoint)orgin andHeight:(CGFloat)height {
    return [[self alloc] initWithOrgin:orgin andHeight:height];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

/**重写datasource的setter方法*/
-(void)setDataSource:(id<DropDownMenuListDataSource>)dataSource {
    /**检查是否匹配*/
    if (_dataSource == dataSource) {
        return;
    }
    _dataSource = dataSource;
    
    /**取前段设置导航栏的内容*/
    if (_dataSource && [_dataSource respondsToSelector:@selector(menuNumberOfRowInColumn)]) {
        self.titleMenuArry = [_dataSource menuNumberOfRowInColumn];
    }
    
    /**选中数据,根据有多少列，则组成由多少数据*/
    self.currentSelectedRows = [[NSMutableArray alloc] initWithCapacity:self.titleMenuArry.count];
    /*! 标识选中的行状态 */
    self.StateCellArry = [[NSMutableArray alloc] initWithCapacity:self.titleMenuArry.count];
    /*! 声明记录选中行的记录用于发用网络请求数据 */
    //self.cellSelectArry = [[NSMutableArray alloc] initWithCapacity:self.titleMenuArry.count];
    
    CGFloat  titleBtnWidth = DDMWIDTH / self.titleMenuArry.count;
    
    for (NSInteger index = 0; index < self.titleMenuArry.count; index++) {
        /**默认添加全部为0*/
        [self.currentSelectedRows addObject:@(0)];
        // 每一列对应返回的数据
        NSInteger column = [_dataSource menu:self numberOfRowsInColum:index];
        
        if (column > 0) {
            HZIndexPath * path = [HZIndexPath indexPathWithColumn:index row:0];
            NSString * titleString = [_dataSource menu:self titleForRowAtIndexPath:path];
            [self.titles addObject:titleString];
        }
        /*! 添加默认选项数据 */
        NSMutableArray * arrys = [[NSMutableArray alloc] init];
        for (NSInteger Cl = 0; Cl < column; Cl++) {
            [arrys addObject:@"Q"];
        }
        [self.StateCellArry addObject:arrys];
        
        
        self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleButton setImage:[UIImage imageNamed:@"rightImage_state"] forState:UIControlStateNormal];
        [self.titleButton setImage:[UIImage imageNamed:@"rightImage_state"] forState:UIControlStateHighlighted];
        [self.titleButton setImage:[UIImage imageNamed:@"rightImage_state_normal"] forState:UIControlStateSelected];
        [self.titleButton setImage:[UIImage imageNamed:@"rightImage_state_normal"] forState:UIControlStateSelected | UIControlStateHighlighted];
        
        
        [self.titleButton setTitle:self.titleMenuArry[index] forState:UIControlStateNormal];
        [self.titleButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [self.titleButton setTitleColor:DDMColor(18, 108, 255) forState:UIControlStateNormal];
        [self.titleButton setTitleColor:DDMColor(18, 108, 255) forState:UIControlStateHighlighted];
        [self.titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected | UIControlStateHighlighted];
        [self.titleButton setAdjustsImageWhenHighlighted:NO];
        
        [self.titleButton setTag:index + 1100];
        self.titleButton.frame = CGRectMake(index * titleBtnWidth, 0, titleBtnWidth, self.titleMenuHeight);
        [self addSubview:self.titleButton];
        [self.titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 设置左右排列
        [self.titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -(self.titleButton.imageView.bounds.size.width + 4), 0, self.titleButton.imageView.bounds.size.width + 4)];
        [self.titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleButton.titleLabel.bounds.size.width, 0, -self.titleButton.titleLabel.bounds.size.width)];
        
        /**添加竖线*/
        if (index > 0) {
            UIImageView *line = [[UIImageView alloc] init];
            line.frame = CGRectMake(titleBtnWidth * index, 10, 0.5, 21);
            line.backgroundColor = DDMColor(220, 220, 220);
            [self addSubview:line];
        }
    }
    /**添加横线*/
    UIView * BottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleButton.frame), DDMWIDTH, 1)];
    BottomLine.backgroundColor = DDMColor(224, 224, 224);
    [self addSubview:BottomLine];
}

-(void)titleButtonClick:(UIButton *)sender {
    self.currrntSelectedColumn = sender.tag;
    
    self.titleButton.selected = NO;
    sender.selected = YES;
    self.titleButton = sender;
    [self removeMenu];
    
    if (sender.selected) {
        [self setupCover];
        self.DropDownMenuView.backgroundColor = DDMColor(255, 255, 255);
        NSInteger coloumn = self.currrntSelectedColumn - 1100;
        /*! 点击更多view */
        if (coloumn == self.titles.count - 1) {
                CGRect frame = CGRectMake(0, self.frame.size.height + self.frame.origin.y, DDMWIDTH, DDMHEIGHT);
                self.DropDownMenuView.frame = frame;
                [CurrentWindow addSubview:self.DropDownMenuView];
                self.moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, 0, DDMWIDTH, DDMHEIGHT - self.frame.size.height - self.frame.origin.y)];
                self.moreView.backgroundColor = [UIColor redColor];
                [self.DropDownMenuView addSubview:self.moreView];
            
            
            return;
        }
        // 1:设置当前选中的状态
        self.selectStateArry = self.StateCellArry[coloumn];
        /*! 对应每列下面有多少行数据 */
        NSInteger coloumCount = [self.dataSource menu:self numberOfRowsInColum:coloumn];
        CGFloat conHeight = 0;
        if (coloumCount >= 5) {
            conHeight = DropMenuContentHeight - SureButtonHeight;
        }else {
            conHeight = 44 * coloumCount;
        }
        
        [UIView animateWithDuration:(self.animationTime) animations:^{
            CGRect frame = CGRectMake(0, self.frame.size.height + self.frame.origin.y, DDMWIDTH, conHeight + SureButtonHeight);
            self.DropDownMenuView.frame = frame;
            [CurrentWindow addSubview:self.DropDownMenuView];
            self.leftTableView.frame = CGRectMake(0, 0, DDMWIDTH  , conHeight);
        }];
        
        /*! 添加确认button */
        self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureButton.frame = CGRectMake(0, CGRectGetMaxY(self.leftTableView.frame), DDMWIDTH, SureButtonHeight);
        self.sureButton.backgroundColor = [UIColor redColor];
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [self.DropDownMenuView addSubview:self.sureButton];
    }
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    // 代理点击事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(menu:didSelectTitleAtColumn:)]) {
        [self.delegate menu:self didSelectTitleAtColumn:sender.tag];
    }
    [self.leftTableView reloadData];
}
-(void)initView {
    self.currrntSelectedColumn = 1100;
}
/*! 确定事件 */
-(void)sureClick {
    [self.cellSelectArry removeAllObjects];
    NSInteger Column = self.currrntSelectedColumn - 1100;
    NSArray * selectArry = self.StateCellArry[Column];
    NSLog(@"----%@",selectArry);
    
    [selectArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * items = (NSString *)obj;
        if ([items isEqualToString:@"L"]) {
            HZIndexPath * path = [HZIndexPath indexPathWithColumn:Column row:idx];
            NSString * str = [self.dataSource menu:self titleForRowAtIndexPath:path];
            [self.cellSelectArry addObject:str];
        }
    }];
    NSLog(@"-------》》%@",self.cellSelectArry);
}


/**
 *  添加遮盖
 */
- (void)setupCover {
    // 添加一个遮盖按钮
    UIButton *cover = [[UIButton alloc] init];
    CGFloat coverY = self.frame.size.height + self.frame.origin.y;
    cover.frame = CGRectMake(0, coverY, DDMWIDTH, DDMHEIGHT);
    
    [UIView animateWithDuration:0.1 animations:^{
        cover.backgroundColor = [DDMColor(0, 0, 0) colorWithAlphaComponent:0.5];
    }];
    
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [CurrentWindow addSubview:cover];
    self.cover = cover;
}


/**
 *  消失
 */
-(void)dismiss {
    [self coverClick];
}


/**
 *  点击了底部的遮盖，遮盖消失
 */
- (void)coverClick {
    [self removeMenu];
    [self resetImageViewTransform];
}

/**
 *  菜单消失
 */
- (void)removeMenu {
    [UIView animateWithDuration:(self.animationTime) animations:^{
        CGRect frame = CGRectMake(0, self.frame.size.height + self.frame.origin.y, DDMWIDTH, 0);
        self.DropDownMenuView.frame = frame;
        self.leftTableView.frame = CGRectMake(0, 0, DDMWIDTH, 0);
        self.cover.alpha = 0;
        [self.cover removeFromSuperview];
        [self.sureButton removeFromSuperview];
        [self.moreView removeFromSuperview];
    }];
}
/**在VC里的ViewwillDisappear的时候使用*/
-(void)rightNowDismis {
    [self removeMenu];
}

/**
 *  回归角标
 */
-(void)resetImageViewTransform {
    for (UIView * view in self.subviews) {
        if (view.tag > 1000) {
            //((UIButton *)view).imageView.transform = CGAffineTransformMakeRotation(0);
            
            /**让所有title重置为normal状态*/
            ((UIButton *)view).selected = NO;
        }
    }
}

/**获取当前window*/
- (UIWindow *)getCurrentWindowView {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    return window;
}
/*! 还原数据 */
-(NSMutableArray *)repleaceWithArry:(NSMutableArray *)repArry {
    NSMutableArray * endArry = [NSMutableArray array];
    [repArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [endArry addObject:@"Q"];
    }];
    return endArry;
}


#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menu:numberOfRowsInColum:)]) {
        return [self.dataSource menu:self numberOfRowsInColum:self.currrntSelectedColumn - 1100];
    }else {
        return 0;
    }
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DropDownCell * cell = [DropDownCell cellWithTableView:tableView];
    HZIndexPath * path = [HZIndexPath indexPathWithColumn:self.currrntSelectedColumn - 1100 row:indexPath.row];
    /*! 更新选中状态 */
    __weak typeof(self) weakSelf = self;
    [cell setStateBlock:^(UIButton *statButton) {
        NSInteger coloum = weakSelf.currrntSelectedColumn - 1100;
        /*! 点击不限清空选中栏目 */
        if (indexPath.row == 0) {
//            NSMutableArray * selectArry = weakSelf.StateCellArry[coloum];
//            [selectArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSString * objs = (NSString *)obj;
//                objs = @"Q";
//            }];
//        [weakSelf.selectStateArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSString * items = (NSString *)obj;
//            items = @"Q";
//            NSLog(@"-------->%@",weakSelf.selectStateArry);
//        }];
            weakSelf.selectStateArry = [weakSelf repleaceWithArry:weakSelf.selectStateArry];
            
        }else {
            if ([statButton.titleLabel.text isEqualToString:@"no"]) {
                [statButton setTitle:@"yes" forState:UIControlStateNormal];
                weakSelf.selectStateArry[indexPath.row] = @"L";
            }else {
                [statButton setTitle:@"no" forState:UIControlStateNormal];
                weakSelf.selectStateArry[indexPath.row] = @"Q";
            }
        }
        [weakSelf.StateCellArry replaceObjectAtIndex:coloum withObject:weakSelf.selectStateArry];
        [tableView reloadData];
    }];
    
    // 文字
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menu:titleForRowAtIndexPath:)]) {
        NSString * str = [self.dataSource menu:self titleForRowAtIndexPath:path];
        [cell setCellTitles:str];
        NSString * strS = self.selectStateArry[indexPath.row];
        [cell setCellState:strS];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self setMenuWithSelectedRow:indexPath.row];
    HZIndexPath * path = [HZIndexPath indexPathWithColumn:self.currrntSelectedColumn - 1100 row:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
        [self.delegate menu:self didSelectRowAtIndexPath:path];
    }
    //[self setSelectTitle:indexPath];
    [self coverClick];
}

#pragma mark - 设置选中cell重新设置成标题
/**设置选中cell重新设置成标题*/
-(void)setSelectTitle:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.15 animations:^{
        NSString * selectTitle = [self titleForRowAtIndexPath:[HZIndexPath indexPathWithColumn:self.currrntSelectedColumn - 1100 row:indexPath.row]];
        UIButton * btn =  (UIButton *)[self viewWithTag:self.currrntSelectedColumn];
        [btn setTitle:selectTitle forState:UIControlStateNormal];
        // 设置左右排列
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(btn.imageView.bounds.size.width + 4), 0, btn.imageView.bounds.size.width + 4)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
    }];
}

/**获取标题*/
-(NSString *)titleForRowAtIndexPath:(HZIndexPath *)indexPath {
    return [self.dataSource menu:self titleForRowAtIndexPath:indexPath];
}

/**默认选中的点击的行*/
-(void)setMenuWithSelectedRow:(NSInteger)row {
    self.currentSelectedRows[self.currrntSelectedColumn - 1100] = @(row);
}


@end
