//
//  enjoysCell.m
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#define EnjoyTextFont [UIFont systemFontOfSize:15]

#import "enjoysCell.h"
#import "enjoyFrame.h"

@implementation enjoysCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /**
         *  加载控件,在数据初始化的时候,数据还没有来,无法判断数据位置
         */
        self.text = [[UILabel alloc] init];
        [self.contentView addSubview:self.text];
        self.text.numberOfLines = 0;
        self.text.font = EnjoyTextFont;
        
        self.names = [[UILabel alloc] init];
        [self.contentView addSubview:self.names];
        
        self.icon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.icon];
        
        self.numbers = [[UILabel alloc] init];
        [self.contentView addSubview:self.numbers];
        
        self.states = [[UILabel alloc] init];
        [self.contentView addSubview:self.states];
        
    }
    return self;
}




//- (void)setEnjoy:(enjoys *)enjoy

- (void)setEnjoyF:(enjoyFrame *)enjoyF
{
   
    _enjoyF = enjoyF;
    NSLog(@"setEnjoyF加载数据");
    /**
     *  加载控件位置
     */
    [self initFrame];
    
    /**
     *  加载数据
     */
    [self initData];
}

/**
 *  加载数据
 */
- (void)initData
{
    
    enjoys *enjoy = self.enjoyF.enjoy;
    self.icon.image = [UIImage imageNamed:enjoy.icon];
    
    self.names.text = enjoy.name;
    
    if (enjoy.numbers.length != 0) {
        self.numbers.hidden = NO;
        self.numbers.text = [NSString stringWithFormat:@"球衣号码:%@号",enjoy.numbers];
    }else
    {
        self.numbers.hidden = YES;
    }
    
    /**
     *  服役状态
     */
    self.states.text = enjoy.states == YES ? @"服役中":@"生涯结束";
    
    
    self.text.text = enjoy.text;
    
}



/**
 *  加载控件位置
 */
- (void)initFrame
{
    
    self.icon.frame = self.enjoyF.iconFrame; //CGRectMake(iconX, iconY, iconW, iconH);
    
    //姓名
    
    self.names.frame = self.enjoyF.nameFrame; //CGRectMake(nameX, nameY, nameW, nameH);
    
    //球衣号码
    
    self.numbers.frame = self.enjoyF.numbersFrame; //CGRectMake(numberX, numberY, numberW, numberH);
    
    
    /**
     *  服役状态
     */
    
    self.states.frame = self.enjoyF.statesFrame; //CGRectMake(statuesX, statuesY, statuesW, statuesH);
    
    
    /**
     *  个人信息
     */
    
    
    self.text.frame = self.enjoyF.textFrame; //CGRectMake(textX, textY, textRect.width, textRect.height);
}






- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}













/**
 *  类方法返回cell
 */
+ (instancetype)cellWtihTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    enjoysCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[enjoysCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return  cell;
}





- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
