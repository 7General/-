//
//  MoreCell.m
//  ReadAddress
//
//  Created by ZZG on 17/5/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MoreCell.h"

@interface MoreCell()
@property (nonatomic, strong) UIButton *addCell;
@property (nonatomic, weak) UIView *consoleView;
@end

@implementation MoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.layer.masksToBounds = YES;
        self.addCell = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addCell.frame = CGRectMake(0, 0, 50, 40);
        self.addCell.backgroundColor = [UIColor redColor];
        [self.addCell addTarget:self action:@selector(addCellClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addCell];
        
        
        
        UIView *consoleView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 300, 20)];
        consoleView.backgroundColor = [UIColor redColor];
        consoleView.hidden = YES;
        [self.contentView addSubview:consoleView];
        self.consoleView = consoleView;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 100, 20);
        btn.backgroundColor = [UIColor yellowColor];
        [consoleView addSubview:btn];
    }
    return self;
}
-(void)setHiddenConsoleView {
    self.consoleView.hidden = YES;
}
-(void)setShowConsoleView {
    self.consoleView.hidden = NO;
}


-(void)setPathIndex:(NSIndexPath *)pathIndex {
    _pathIndex = pathIndex;
}
-(void)setcellWithTitle:(NSString *)titles {
    [self.addCell setTitle:titles forState:UIControlStateNormal];
}

-(void)addCellClick {
    [self.delegate updataCellHeightCustom:self.pathIndex];

}

+(instancetype)cellWithTableView:(UITableView *)tableView {
 static NSString * ID = @"ID";
    MoreCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *subView in self.subviews) {
        
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            UIView *deleteConfirmationView = subView.subviews[1];
            //改背景颜色
            deleteConfirmationView.backgroundColor = [UIColor whiteColor];
            for (UIView *deleteView in deleteConfirmationView.subviews) {
                NSLog(@"%@",deleteConfirmationView.subviews);
                UIImageView *deleteImage = [[UIImageView alloc] init];
                deleteImage.contentMode = UIViewContentModeScaleAspectFit;
                deleteImage.image = [UIImage imageNamed:@"right_menu_multichat"];
                deleteImage.frame = CGRectMake(0, 0, deleteView.frame.size.width, deleteView.frame.size.height);
                [deleteView addSubview:deleteImage];
            }
            
            // 这里是右边的
            UIView *shareConfirmationView = subView.subviews[0];
            //shareConfirmationView.backgroundColor = [UIColor colorWithRed:142.0/255.0 green:201.0/255.0 blue:75.0/255.0 alpha:1.0];
            shareConfirmationView.backgroundColor = [UIColor whiteColor];
            for (UIView *shareView in shareConfirmationView.subviews) {
                UIImageView *shareImage = [[UIImageView alloc] init];
                shareImage.contentMode = UIViewContentModeScaleAspectFit;
                shareImage.image = [UIImage imageNamed:@"right_menu_facetoface"];
                shareImage.frame = CGRectMake(0, 0, shareView.frame.size.width, shareView.frame.size.height);
                [shareView addSubview:shareImage];
            }
        }
    }

}

@end
