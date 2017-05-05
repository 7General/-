//
//  MainViewController.m
//  ReadAddress
//
//  Created by admin on 17/5/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#import "MainViewController.h"


#import "ReadAddressViewController.h"
#import "WakeAddressViewController.h"
#import "SheetTopViewController.h"
#import "RightToleftController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong) NSMutableArray *myData;

@end

@implementation MainViewController
-(NSMutableArray *)myData {
    if (_myData == nil) {
        _myData = [NSMutableArray array];
    }
    return _myData;
}
-(void)initMyDataTitle {
    [self.myData addObject:@"调用通讯录页面"];
    [self.myData addObject:@"获取通讯录数据"];
    [self.myData addObject:@"从下向上Sheet"];
    [self.myData addObject:@"从右向左Sheet"];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    char a[] = "123";
    char b[] = "456";
    int c;
    c = atoi(a) + atoi(b);
    printf("c=%d\n", c);
    */
    
    [self initMyDataTitle];
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString * ID = @"ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.myData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /* 唤醒手机通讯录界面 */
    if (indexPath.row == 0) {
        WakeAddressViewController * wakes = [[WakeAddressViewController alloc] init];
        [self.navigationController pushViewController:wakes animated:YES];
    }
    /* 获取手机通讯录列表信息 */
    if (indexPath.row == 1) {
        ReadAddressViewController * read = [[ReadAddressViewController alloc] init];
        [self.navigationController pushViewController:read animated:YES];
    }
    /* sheet从下向上 */
    if (indexPath.row == 2) {
        SheetTopViewController * sheetop = [[SheetTopViewController alloc] init];
        [self.navigationController pushViewController:sheetop animated:YES];
    }
    /* sheet从右向左 */
    if (indexPath.row == 3) {
        RightToleftController * right = [[RightToleftController alloc] init];
        [self.navigationController pushViewController:right animated:YES];
    }
}









@end
