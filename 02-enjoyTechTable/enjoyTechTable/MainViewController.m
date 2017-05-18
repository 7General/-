//
//  MainViewController.m
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MainViewController.h"
#import "enjoysCell.h"
#import "enjoys.h"
#import "enjoyFrame.h"
#import "enjoyFooteView.h"
#import "enjoysHeaderView.h"

@interface MainViewController ()


@property(nonatomic,copy)NSMutableArray *enjoyArry;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.table = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.table];
    
    
    
    /**
     *  添加代理
     */
    self.table.dataSource = self;
    self.table.delegate = self;
 
    
    
    //添加头部控件
    enjoysHeaderView *headerV = [enjoysHeaderView enjoysHeader];
    self.table.tableHeaderView = headerV;
    
    //headerV.frame = CGRectMake(0, 0, 320, 200);
    //headerV.backgroundColor = [UIColor redColor];
    
    
    enjoyFooteView *footView = [enjoyFooteView footerView];
    self.table.tableFooterView = footView;
    /**
     *  设置代理
     */
    footView.delegate =self;
   
}

/**
 *  返回数据行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.enjoyArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    enjoysCell *cell = [enjoysCell cellWtihTableView:tableView];
    
    cell.enjoyF = self.enjoyArry[indexPath.row];
    
    return cell;
}

/**
 *  隐藏状态栏
 */

- (BOOL)prefersStatusBarHidden
{
    return  YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 300;
    /**
     * 在table初始化加载的时候,计算行的高度的fun首优先于加载cell
     先把行高计算完成,在加载cell
     */
    
    enjoyFrame *ef = self.enjoyArry[indexPath.row];
    return ef.cellHeight;
}


/**
 *  延迟加载数据
 */
- (NSMutableArray *)enjoyArry
{
    if (_enjoyArry == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"athletes.plist" ofType:nil];
        NSArray *dictArry = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *resyltArry = [NSMutableArray array];
        for (NSDictionary *dict in dictArry) {
            /**
             *  创建模型数据
             */
            enjoys *enjoy = [enjoys enjoysWithDict:dict];
            
            /**
             *  得到模数据(frame + data)
             */
            
            enjoyFrame *ef = [[enjoyFrame alloc]init];
            
            ef.enjoy = enjoy;
            
            
            [resyltArry addObject:ef];
        }
        _enjoyArry = resyltArry;
    }

    return _enjoyArry;
}

/**
 *  实现代理方法
 *
 *  @param footView <#footView description#>
 */
- (void)enjoyFootViewDidClickLoadButton:(enjoyFooteView *)footView
{
    enjoys *enjoy = [[enjoys alloc] init];
    
    enjoy.icon = @"y6.jpg";
    enjoy.name = @"易建联";
    enjoy.numbers = @"9";
    enjoy.states = YES;
    enjoy.text = @"易建联，1987年10月27日出生于中国广东省鹤山市，前NBA球星，著名篮球运动员，中国男篮运动员，中国国家篮球队队长，司职小前锋，大前锋及中锋。毕业于广东工业大学。2002年，15岁的易建联进入CBA并为广东宏远队效力。 2004年，入选中国国家男子篮球队。2005年，成为CBA史上最年轻的MVP。 2007年，NBA选秀中易建联以第六位的成绩被密尔沃基雄鹿队选中。2008年，转会至新泽西网队。 2010年6月30日，转会至华盛顿奇才队。 2011年10月8日，易建联重回CBA为广东效力。 2012年1月，易建联签约NBA达拉斯小牛队；7月，易建联作为中国代表团旗手参加2012年伦敦奥运会；9月23日，易建联正式回归广东队，赛季结束时帮助广东队再获CBA总冠军。 2014年3月24日，《体坛周报》发布了2013年中国体坛财富榜，易建联并列第六名。[2] 2014年9月29日，易建联通过微博上宣布儿子出生，升级做爸爸。";
    
    enjoyFrame *ef = [[enjoyFrame alloc]init];
    ef.enjoy = enjoy;
    
    [self.enjoyArry addObject:ef];
    
    [self.table reloadData];
}






@end
