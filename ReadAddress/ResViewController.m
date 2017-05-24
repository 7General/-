//
//  ResViewController.m
//  ReadAddress
//
//  Created by ZZG on 17/5/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ResViewController.h"
#import "requeCell.h"

@interface ResViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *dictData;

@property (nonatomic, strong) NSMutableArray *arryData;

@end

@implementation ResViewController

-(NSMutableArray *)arryData {
    if (_arryData == nil) {
        _arryData = [NSMutableArray array];
    }
    return _arryData;
}

-(NSMutableDictionary *)dictData {
    if (_dictData == nil) {
        _dictData = [NSMutableDictionary dictionary];
    }
    return _dictData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arryData = @[@"北京",@"海南",@"河南",@"四川",@"广州",@"新疆",@"广西",@"甘肃"].mutableCopy;
    self.dictData = @{
                      @"北京":@[@"朝阳",@"海淀"],
                      @"海南":@[@"海南1",@"海南2",@"海南4",@"海南4",@"海南5",@"海南6",@"海南7"],
                      @"河南":@[@"郑州",@"南阳",@"三门峡"],
                      @"四川":@[@"四川1",@"四川2",@"四川3",@"四川3",@"四川3",@"四川3"],
                      @"广州":@[@"广州1",@"广州2",@"广州3",@"广州3",@"广州3",@"广州3"],
                      @"新疆":@[@"新疆1",@"新疆2",@"新疆3",@"新疆3",@"新疆3",@"新疆3"],
                      @"广西":@[@"广西1",@"广西2",@"广西3",@"广西3"],
                      @"甘肃":@[@"甘肃1",@"甘肃2",@"甘肃3",@"甘肃3",@"甘肃3",@"甘肃3"],
                      
                      }.mutableCopy;
    
    
    UITableView * table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arryData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    requeCell * cell = [requeCell cellWithTable:tableView];
    NSString * items = self.arryData[indexPath.row];
    NSArray * array = self.dictData[items];
    [cell initView:array];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString * items = self.arryData[indexPath.row];
    NSArray * array = self.dictData[items];
//    if (array % 3 == 0) {
//        return  44 * 3
//    }
    
    return 150;
}
@end
