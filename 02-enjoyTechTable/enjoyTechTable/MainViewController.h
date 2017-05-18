//
//  MainViewController.h
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewControllerDelegate.h"

@interface MainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,mainViewControllerDelegate>


@property(nonatomic,retain)UITableView *table;

@end
