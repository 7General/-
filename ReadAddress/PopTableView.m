//
//  PopTableView.m
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//


#define DDMWIDTH [UIScreen mainScreen].bounds.size.width
#define DDMHEIGHT [UIScreen mainScreen].bounds.size.height
#define DDMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "PopTableView.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "TableViewHeaderView.h"
#import "CategoryModel.h"


CGFloat const PopTableViewContentHeight = 150.f;


@interface PopTableView()<UITableViewDelegate,UITableViewDataSource>
/*! 起始点 */
@property (nonatomic, assign) CGFloat  StartPointY;
/*! 底层 */
@property (nonatomic, strong) UIView * contentView;
/**
 *  动画持续时间
 */
@property (nonatomic, assign) CGFloat animationTime;


/*! 左边table */
@property (nonatomic, strong) UITableView * leftTableView;
/*! 右边Table */
@property (nonatomic, strong) UITableView * rightTableView;
/*! 右边数据源 */
@property (nonatomic, strong) NSMutableArray *categoryData;
/*! 左边数据源 */
@property (nonatomic, strong) NSMutableArray *rightTableData;



@property (nonatomic, assign) NSInteger  selectIndex;
@property (nonatomic, assign) BOOL  isScrollDown;



@end

@implementation PopTableView
{
    CGPoint _startPoint;
}

#pragma mark - lazy
- (NSMutableArray *)categoryData {
    if (!_categoryData) {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}
- (NSMutableArray *)rightTableData {
    if (!_rightTableData) {
        _rightTableData = [NSMutableArray array];
    }
    return _rightTableData;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, PopTableViewContentHeight)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 0, DDMWIDTH - 80, PopTableViewContentHeight)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Right];
    }
    return _rightTableView;
}


-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)StartPointY {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, DDMWIDTH, DDMHEIGHT - StartPointY)];
    if (self) {
        _startPoint = origin;
        self.StartPointY = StartPointY;
        self.animationTime = 0.25;
        self.selectIndex = 0;
        self.isScrollDown = YES;
        [self initMasyView];
        [self.contentView addSubview:self.leftTableView];
        [self.contentView addSubview:self.rightTableView];
    }
    return self;
}


-(void)initMasyView {
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor redColor];
    //CGRect rect = self.frame;
    //rect.origin.y = -PopTableViewContentHeight;
    self.contentView.frame = CGRectMake(_startPoint.x, 0, DDMWIDTH, 0);
    [self addSubview:self.contentView];
}


/**
 *  菜单消失
 */
- (void)removeMenu {
    [UIView animateWithDuration:self.animationTime animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



-(void)setDataSource:(id<PopTableViewDelegate>)dataSource {
    /**检查是否匹配*/
    if (_dataSource == dataSource) {
        return;
    }
    _dataSource = dataSource;
    /*! 获取数据源 */
    if (_dataSource && [_dataSource respondsToSelector:@selector(popLeftTableView:)]) {
        self.categoryData = [_dataSource popLeftTableView:self];
        self.rightTableData = [_dataSource popRightTableView:self];
        
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissThePopView];
}

- (void)dismissThePopView {
    [UIView animateWithDuration:self.animationTime animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)show{
    UIWindow * window = [self mainWindow];
    [window addSubview:self];
    //1.执行动画
    [UIView animateWithDuration:self.animationTime animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//        self.contentView.transform = CGAffineTransformMakeTranslation(0, PopTableViewContentHeight);
        self.contentView.frame = CGRectMake(_startPoint.x, 0, DDMWIDTH, PopTableViewContentHeight);
       self.backgroundColor = [UIColor colorWithWhite:0.614 alpha:0.600];
    }];
}


#pragma mark - UITABLEVIEWDELEGATE
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.leftTableView == tableView) {
        return 1;
    }else {
        return self.categoryData.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.leftTableView == tableView) {
        return self.categoryData.count;
    }else {
        return [self.rightTableData[section] count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_leftTableView == tableView) {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
        rightTableModel *model = self.categoryData[indexPath.row];
        cell.name.text = model.name;
        return cell;
    } else {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Right forIndexPath:indexPath];
        rightTableModel *model = self.rightTableData[indexPath.section][indexPath.row];
        cell.model = model;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_rightTableView == tableView) {
        return 20;
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_rightTableView == tableView) {
        TableViewHeaderView *view = [[TableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, DDMWIDTH - 80, 20)];
        rightTableModel *model = self.categoryData[section];
        view.name.text = model.name;
        return view;
    }
    return nil;
}


// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && !_isScrollDown && _rightTableView.dragging) {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && _isScrollDown && _rightTableView.dragging) {
        [self selectRowAtIndexPath:section + 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (_leftTableView == tableView) {
        _selectIndex = indexPath.row;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else {
        NSLog(@"))))))________________________");
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(popTableView:didSelectIndexPath:)]) {
            [self.dataSource popTableView:self didSelectIndexPath:indexPath];
            [self dismissThePopView];
        }
    }
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index {
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
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
