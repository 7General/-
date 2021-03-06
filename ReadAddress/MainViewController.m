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


#import "ZZGPopoverView.h"
#import "TableViewController.h"

#import "PopTableViewController.h"
#import "RerequesController.h"
#import "CellAnimateController.h"
#import "CMSViewController.h"

#import "UIView+UIViewUtils.h"
#import "CellViewController.h"
#import "ResViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,ZZGPopoverViewDelegate>



@property (nonatomic, strong) NSMutableArray *myData;

@property (nonatomic, strong) NSMutableArray *popoverData;

@end

@implementation MainViewController
-(NSMutableArray *)myData {
    if (_myData == nil) {
        _myData = [NSMutableArray array];
    }
    return _myData;
}

-(NSMutableArray *)popoverData {
    if (_popoverData == nil) {
        _popoverData = [NSMutableArray array];
    }
    return _popoverData;
}

-(void)initMyDataTitle {
    [self.myData addObject:@"调用通讯录页面"];
    [self.myData addObject:@"获取通讯录数据"];
    [self.myData addObject:@"从下向上Sheet"];
    [self.myData addObject:@"从右向左Sheet"];
    [self.myData addObject:@"TableView联动"];
    [self.myData addObject:@"PopTableView联动"];
    [self.myData addObject:@"多个tableview复用"];
    [self.myData addObject:@"cell侧滑显示image"];
    [self.myData addObject:@"cell显示动画"];
    [self.myData addObject:@"调取发送短信界面"];
    [self.myData addObject:@"tbaleview9宫格"];
}
-(void)initPopoverData {
    ZZGPopoverAction * o1 = [ZZGPopoverAction actionWithTitle:@"新增客户" forimage:[UIImage imageNamed:@"right_menu_multichat"]];
    ZZGPopoverAction * o2 = [ZZGPopoverAction actionWithTitle:@"加好友" forimage:[UIImage imageNamed:@"right_menu_addFri"]];
    ZZGPopoverAction * o3 = [ZZGPopoverAction actionWithTitle:@"扫一扫" forimage:[UIImage imageNamed:@"right_menu_QR"]];
    ZZGPopoverAction * o4 = [ZZGPopoverAction actionWithTitle:@"面对面快传" forimage:[UIImage imageNamed:@"right_menu_facetoface"]];
    ZZGPopoverAction * o5 = [ZZGPopoverAction actionWithTitle:@"付款" forimage:[UIImage imageNamed:@"right_menu_payMoney"]];
    [self.popoverData addObjectsFromArray:@[o1,o2,o3,o4,o5]];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMyDataTitle];
    [self initPopoverData];
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn addTarget:self action:@selector(barClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = barItem;
    
    
    UIButton * rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(100, 100, 50, 50);
    rightBtn1.backgroundColor = [UIColor redColor];
    [rightBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn1];
    
    /*
    UITextField * texts = [[UITextField  alloc] initWithFrame:CGRectMake(10,SCREEN_HEIGHT - 50 , SCREEN_WIDTH - 20, 50)];
    texts.backgroundColor = [UIColor redColor];
    [self.view addSubview:texts];
    
    
    UITextField * text2 = [[UITextField  alloc] initWithFrame:CGRectMake(10,SCREEN_HEIGHT - 120 , SCREEN_WIDTH - 20, 50)];
    text2.backgroundColor = [UIColor redColor];
    [self.view addSubview:text2];
     */
    
//    [self testDevice];
    //NSArray * arrys = @[@"1",@"2",@"4"].mutableCopy;
//    NSLog(@"-----%@",arrys[5]);
}





-(void)btnClick:(UIButton *)sender {
//    [self barClick:sender];
    /*! 带交表提示 正确  自动消失 */
    //[self.view showHUDIndicatorViewSuccessAtCenter:@"dddddd"];
    /*! 带角标提示 错误  自动消失 */
//    [self.view showHUDIndicatorViewErrorAtCenter:@"dddddd"];
    /*! 提示语句，不带任何图标，自动消失 */
    //[self.view showHUDIndicatorLabelAtCenter:@"提示语句"];
    
    /*! 菊花转，后面有黑色影音 -网络加载*/
    /*
    [self.view showHUDIndicatorAtCenter:@"菊花转"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view hideHUDIndicatorViewAtCenter];
    });
     */
    
//    
//    [self.view showHUDIndicatorViewAtCenter:@"正在加载"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self.view hideHUDIndicatorViewAtCenter];
//        [self.view showHUDIndicatorLabelAtCenter:@"网络加载失败"];
//    });
    
    
//    [self.view showHUDIndicatorViewAtCenter:@"警告" yOffset:100];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self.view hideHUDIndicatorViewAtCenter];
//        [self.view showHUDIndicatorLabelAtCenter:@"网络加载失败"];
//    });
    
    
//    [self.view showHUDIndicatorViewETaxAtCenter];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self.view hideHUDIndicatorViewAtCenter];
////         [self.view showHUDIndicatorLabelAtCenter:@"网络加载失败"];
//        [self.view showHUDIndicatorViewSuccessAtCenter:@"加载成功"];
//    });
    [self showNewStatausCount:12];
}



-(void)showNewStatausCount:(int)count{
    //创建uibutton
    UIButton *btn =[[UIButton alloc]init];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    //设置btn属性
    btn.userInteractionEnabled=NO;
   
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    if (count) {
        NSString *title =[NSString stringWithFormat:@"共有%d条新的微博",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    //设置按钮的frame
    CGFloat btnH=30;
    CGFloat btnY =64-btnH;
    CGFloat btnX =0;
    CGFloat btnW =self.view.frame.size.width;
    btn.frame =CGRectMake(btnX, btnY, btnW, btnH);
    //设置动画
    [UIView animateWithDuration:0.7 animations:^{
        //向下移动btn
        btn.transform=CGAffineTransformMakeTranslation(0, btnH+1);
    } completion:^(BOOL finished) {
        //向上移动btn
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform=CGAffineTransformIdentity;//清空transform
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}





-(void)barClick:(UIButton *)sender {
    NSLog(@"-------");
    ZZGPopoverView *popoverView = [ZZGPopoverView popoverView];
    popoverView.popDelegate = self;
    [popoverView showToView:sender withActions:self.popoverData];
}
#pragma mark - ZZGPopoverViewDELEGATE
-(void)popoverView:(ZZGPopoverView *)popView didSelectIndex:(NSIndexPath *)indexPath {
    NSLog(@"--------%ld",indexPath.row);
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
    if (indexPath.row == 4) {
        TableViewController * tables = [[TableViewController alloc] init];
        [self.navigationController pushViewController:tables animated:YES];
    }
    if (indexPath.row == 5) {
        PopTableViewController * popTable = [[PopTableViewController alloc] init];
        [self.navigationController pushViewController:popTable animated:YES];
    }
    if (indexPath.row == 6) {
        RerequesController * req = [[RerequesController alloc] init];
        [self.navigationController pushViewController:req animated:YES];
    }
    if (indexPath.row == 7) {
        CellViewController * cells = [[CellViewController alloc] init];
        [self.navigationController pushViewController:cells animated:YES];
    }
    if (indexPath.row == 8) {
        CellAnimateController * anima = [[CellAnimateController alloc] init];
        [self.navigationController pushViewController:anima animated:YES];
    }
    if (indexPath.row == 9) {
        CMSViewController * cms = [[CMSViewController alloc] init];
        [self.navigationController pushViewController:cms animated:YES];
    }
    if (indexPath.row == 10) {
        ResViewController * res = [[ResViewController alloc] init];
        [self.navigationController pushViewController:res animated:YES];
    }
}









@end
