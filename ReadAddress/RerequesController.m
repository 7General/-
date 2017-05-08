//
//  RerequesController.m
//  ReadAddress
//
//  Created by admin on 17/5/8.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "RerequesController.h"
#import "DropDownMenuList.h"

@interface RerequesController ()<DropDownMenuListDelegate,DropDownMenuListDataSource>

@property (nonatomic, strong) DropDownMenuList * dropMenu;


@property (nonatomic, strong) NSMutableArray * sort;
@property (nonatomic, strong) NSMutableArray * classIfy;
@property (nonatomic, strong) NSMutableArray * yetai;
@property (nonatomic, strong) NSMutableArray * fenzu;
@property (nonatomic, strong) NSMutableArray * mores;

@end

@implementation RerequesController


-(NSMutableArray *)sort {
    if (_sort == nil) {
        _sort = [NSMutableArray new];
        [_sort addObject:@"不限"];
        [_sort addObject:@"1"];
        [_sort addObject:@"2"];
        [_sort addObject:@"2.5"];
        [_sort addObject:@"3"];
    }
    return _sort;
}
-(NSMutableArray *)classIfy {
    if (!_classIfy) {
        _classIfy = [NSMutableArray new];
        [_classIfy addObject:@"不限"];
        [_classIfy addObject:@"A"];
        [_classIfy addObject:@"B"];
        [_classIfy addObject:@"C"];
        [_classIfy addObject:@"D"];
        [_classIfy addObject:@"E"];
        [_classIfy addObject:@"F"];
    }
    return _classIfy;
}
-(NSMutableArray *)yetai {
    if (_yetai == nil) {
        _yetai = [NSMutableArray array];
        [_yetai addObject:@"不限"];
        [_yetai addObject:@"高层平层"];
        [_yetai addObject:@"高层复式"];
        [_yetai addObject:@"小高层"];
        [_yetai addObject:@"洋房"];
        [_yetai addObject:@"上碟"];
        [_yetai addObject:@"中谍"];
    }
    return _yetai;
}

-(NSMutableArray *)fenzu {
    if (_fenzu == nil) {
        _fenzu = [NSMutableArray array];
        [_fenzu addObject:@"不限"];
    }
    return _fenzu;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.dropMenu rightNowDismis];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"tableview复用";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dropMenu = [DropDownMenuList show:CGPointMake(0, 64) andHeight:44];
    self.dropMenu.delegate = self;
    self.dropMenu.dataSource = self;
    [self.view addSubview:self.dropMenu];
    
}
-(NSMutableArray *)menuNumberOfRowInColumn {
    return @[@"客储",@"意向",@"业态",@"分组",@"更多"].mutableCopy;
}

-(NSInteger)menu:(DropDownMenuList *)menu numberOfRowsInColum:(NSInteger)column {
    if (column == 0) {
        return self.sort.count;
    }else if(column == 1) {
        return self.classIfy.count;
    }else if(column == 2){
        return self.yetai.count;
    }else{
        return self.fenzu.count;
    }
    
}

-(NSString *)menu:(DropDownMenuList *)menu titleForRowAtIndexPath:(HZIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.sort[indexPath.row];
    }else if(indexPath.column == 1) {
        return self.classIfy[indexPath.row];
    }else if(indexPath.column == 2){
        return self.yetai[indexPath.row];
    }else{
        return self.fenzu[indexPath.row];
    }
    
}
-(void)menu:(DropDownMenuList *)segment didSelectRowAtIndexPath:(HZIndexPath *)indexPath {
    NSLog(@"------%ld----->>>%ld",indexPath.column,indexPath.row);
}



@end
