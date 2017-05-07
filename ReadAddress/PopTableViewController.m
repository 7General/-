//
//  PopTableViewController.m
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PopTableViewController.h"
#import "PopTableView.h"

#import "CategoryModel.h"
#import "NSObject+Property.h"

@interface PopTableViewController ()<PopTableViewDelegate>
/*! 右边数据源 */
@property (nonatomic, strong) NSMutableArray *categoryData;
/*! 左边数据源 */
@property (nonatomic, strong) NSMutableArray *rightTableData;


@property (nonatomic, strong) PopTableView * popV;
@end

@implementation PopTableViewController

- (NSMutableArray *)categoryData {
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}
- (NSMutableArray *)rightTableData {
    if (!_rightTableData)
    {
        _rightTableData = [NSMutableArray array];
    }
    return _rightTableData;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.popV dismissThePopView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"right_menu_addFri"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(barClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = barItem;
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meituan" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *foods = dict[@"data"][@"food_spu_tags"];
    
    for (NSDictionary *dict in foods)
    {
        CategoryModel *model = [CategoryModel objectWithDictionary:dict];
        [self.categoryData addObject:model];
        
        NSMutableArray *datas = [NSMutableArray array];
        for (rightTableModel *f_model in model.spus)
        {
            [datas addObject:f_model];
        }
        [self.rightTableData addObject:datas];
    }
    
    UIButton * rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(10, 300, 100, 44);
    rightBtn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:rightBtn1];
}

-(void)barClick:(UIButton *)sender {

    NSLog(@"_____________________");
   self.popV = [[PopTableView alloc] initWithOrgin:CGPointMake(0, 64) andHeight:64];
    self.popV.dataSource = self;
    [self.popV show];
}

#pragma mark - PopTableViewDELEGATE
-(NSMutableArray *)popLeftTableView:(PopTableView *)popView {
    return self.categoryData;
}
-(NSMutableArray *)popRightTableView:(PopTableView *)popView {
   return self.rightTableData;
}
-(void)popTableView:(PopTableView *)popView didSelectIndexPath:(NSIndexPath *)indexPath {
   NSArray * arry = self.rightTableData[indexPath.section];
    rightTableModel * model = arry[indexPath.row];
    NSLog(@"------%@",model.name);

}


@end
