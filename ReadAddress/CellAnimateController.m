//
//  CellAnimateController.m
//  ReadAddress
//
//  Created by hzbj on 17/5/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CellAnimateController.h"
#import "AnimateCell.h"

@interface CellAnimateController ()<UITableViewDataSource,UITableViewDelegate,AnimateCellDelegate>

@property (nonatomic, strong) NSMutableArray *arryData;
@property (nonatomic, weak) UITableView *myTableView;

@property (nonatomic, strong) NSMutableDictionary *selectIndexDic;


@end

@implementation CellAnimateController


-(NSMutableDictionary *)selectIndexDic {
    if (_selectIndexDic == nil) {
        _selectIndexDic = [NSMutableDictionary dictionary];
    }
    return _selectIndexDic;
}

-(NSMutableArray *)arryData {
    if (_arryData == nil) {
        _arryData = [NSMutableArray array];
        [_arryData addObject:@"w"];
        [_arryData addObject:@"x"];
        [_arryData addObject:@"y"];
        [_arryData addObject:@"z"];
        [_arryData addObject:@"a"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"a"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
        [_arryData addObject:@"b"];
    }
    return _arryData;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    self.myTableView = tableview;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arryData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnimateCell * cell = [AnimateCell cellWithTableView:tableView];
    cell.pathIndex = indexPath;
    cell.delegate = self;
    [cell setcellWithTitle:self.arryData[indexPath.row]];
    if ([self cellIsSelected:indexPath]) {
        [cell setShowConsoleView];
    }else {
        [cell setHiddenConsoleView];
    }
    return cell;
}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
    NSNumber *selectedIndex = [self.selectIndexDic objectForKey:indexPath];
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}
-(void)animateCellHeightCustom:(NSIndexPath *)path {
    NSLog(@"----%ld",path.row);
    BOOL isSelected = ![self cellIsSelected:path];
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [self.selectIndexDic setObject:selectedIndex forKey:path];
    [self.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)consoleCellSelectIndex:(NSInteger)selectTag didselectIndexPath:(NSIndexPath *)path{
    [self.selectIndexDic removeObjectForKey:path];
    NSLog(@"-----------%ld",selectTag);
    [self.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}



@end
