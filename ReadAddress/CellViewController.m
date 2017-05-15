//
//  CellViewController.m
//  ReadAddress
//
//  Created by ZZG on 17/5/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CellViewController.h"
#import "MoreCell.h"

@interface CellViewController ()<UITableViewDataSource,UITableViewDelegate,MoreCellDelegate>
@property (nonatomic, strong) NSMutableArray *arryData;
@property (nonatomic, weak) UITableView *myTableView;

@property (nonatomic, strong) NSMutableDictionary *selectIndexDic;

@end

@implementation CellViewController
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
    MoreCell * cell = [MoreCell cellWithTableView:tableView];
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

-(void)updataCellHeightCustom:(NSIndexPath *)path {
    NSLog(@"----%ld",path.row);
    BOOL isSelected = ![self cellIsSelected:path];
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [self.selectIndexDic setObject:selectedIndex forKey:path];
    
    [self.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self cellIsSelected:indexPath]) {
        return 80;
    }else {
        return 50;
    }
}

#pragma mark -- cell左滑动退出班级
//设cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//设置滑动时显示多个按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //添加一个删除按钮
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了删除");
//        //1.更新数据
//        //[self.dataArray removeObjectAtIndex:indexPath.row];
//        //2.更新UI
//        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
//    }];
//    //删除按钮颜色
//    deleteAction.backgroundColor = [UIColor cyanColor];
//    //添加一个置顶按钮
//    UITableViewRowAction *topRowAction =[UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了置顶");
//        //1.更新数据
//        //[self.dataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
//        //2.更新UI
//        NSIndexPath *firstIndexPath =[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
//        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
//    }];
//    //置顶按钮颜色
//    topRowAction.backgroundColor = [UIColor magentaColor];
////    //--------更多
////    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"    " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
////        NSLog(@"更多");
////        //DetailViewController *detailVC = [[DetailViewController alloc]init];
////        //[self.navigationController pushViewController:detailVC animated:YES];
////
////    }];
////    //背景特效
////    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
////    //----------收藏
////    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"    " handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
////        NSLog(@"收藏");
////
////    }];
//    //收藏按钮颜色
//    //collectRowAction.backgroundColor = [UIColor greenColor];
//
//    //将设置好的按钮方到数组中返回
//    //return @[deleteAction,topRowAction,moreRowAction,collectRowAction];
//    return @[deleteAction,topRowAction];
    
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"           " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击删除");
    }];
    
    UITableViewRowAction *shareRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"           " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击分享");
    }];
    
    // 这个地方：先加入的在右边
    return @[shareRowAction, deleteRowAction];
    
}


@end
