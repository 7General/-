//
//  DropDownCell.m
//  ReadAddress
//
//  Created by admin on 17/5/8.
//  Copyright © 2017年 admin. All rights reserved.
//

#define DDMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "DropDownCell.h"



@interface DropDownCell()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *currentButton;

@end

@implementation DropDownCell
+(instancetype)cellWithTableView:(UITableView *)tableview {
     static NSString * ID = @"ID";
    DropDownCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DropDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(void)setStateBlock:(stateSelectClik)stateBlock {
    _stateBlock = [stateBlock copy];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton * currentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        currentButton.frame = self.contentView.bounds;
        [currentButton addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:currentButton];
        self.currentButton = currentButton;
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, self.contentView.bounds.size.height)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = DDMColor(9, 177, 247);
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.highlightedTextColor = [UIColor redColor];
        [self.currentButton addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIButton * stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        stateButton.frame = CGRectMake(self.contentView.bounds.size.width - 50, 0, 50, self.contentView.bounds.size.height);
        stateButton.titleLabel.textColor = [UIColor redColor];
        [stateButton setTitle:@"no" forState:UIControlStateNormal];
        stateButton.backgroundColor = [UIColor lightGrayColor];
        [stateButton addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.currentButton addSubview:stateButton];
        self.stateButton = stateButton;
    }
    return self;
}

-(void)setCellTitles:(NSString *)titles {
    self.titleLabel.text = titles;
}
-(void)setCellState:(NSString *)states {
    if ([states isEqualToString:@"Q"]) {
        [self.stateButton setTitle:@"no" forState:UIControlStateNormal];
    }else {
       [self.stateButton setTitle:@"yes" forState:UIControlStateNormal];
    }
}

-(void)stateClick:(UIButton *)sender {
    NSLog(@"----");
    if (self.stateBlock) {
        self.stateBlock(sender);
    }
}
-(void)cellClick:(UIButton *)sender {
    for (UIView * view in sender.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (self.stateBlock) {
                self.stateBlock((UIButton *)view);
            }
        }
    }
}

@end
