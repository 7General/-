//
//  MoreCell.m
//  ReadAddress
//
//  Created by admin on 17/5/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MoreCell.h"

@interface MoreCell()
@property (nonatomic, weak) UILabel *titles;
@property (nonatomic, weak) UIView *contView;
@end

@implementation MoreCell
+(instancetype)cellWithTableView:(UITableView *)tableView {
   static NSString * ID = @"ID";
    MoreCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView {
    /*! 标题 */
    UILabel *titles = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    titles.backgroundColor = [UIColor lightGrayColor];
    titles.textColor = [UIColor redColor];
    titles.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:titles];
    self.titles = titles;
    
    CGFloat cX = 10;
    CGFloat cY = CGRectGetMaxY(titles.frame);
    CGFloat cW = self.contentView.bounds.size.width - 20;
    CGFloat cH = 100;
    
    UIView * contView = [[UIView alloc] initWithFrame:CGRectMake(cX,cY , cW, cH)];
    contView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:contView];
    self.contView = contView;

}

-(void)setCellWithData:(NSArray *)contents {
    NSLog(@"-----:%@",contents);
    CGFloat maxW = self.contentView.bounds.size.width - 20;
    [self.contView.subviews respondsToSelector:@selector(removeFromSuperview)];
    for (NSInteger row = 0; row < contents.count; row++) {
        UIButton * conBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        conBtn.frame = CGRectMake(row * 52, 10, 50, 40);
        conBtn.backgroundColor = [UIColor darkTextColor];
        [conBtn setTitle:contents[row] forState:UIControlStateNormal];
        [self.contView addSubview:conBtn];
    }
    
}

-(void)setCellWithTitle:(NSString *)titles {
    self.titles.text = titles;
}

@end
