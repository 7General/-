//
//  enjoyFrame.m
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//



// 昵称的字体
#define EnjoyTextFont [UIFont systemFontOfSize:15]
#import "enjoyFrame.h"

@implementation enjoyFrame


-(void)setEnjoy:(enjoys *)enjoy
{
    NSLog(@"222222222222222");
    _enjoy = enjoy;
    
    CGFloat paddding = 20;
    CGFloat iconX = paddding;
    CGFloat iconY = paddding;
    
    CGFloat iconW = 80;
    CGFloat iconH = 150;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //姓名
    CGFloat nameX = CGRectGetMaxX(_iconFrame) + paddding;
    CGFloat nameY = iconY;
    CGFloat nameW = 150;
    CGFloat nameH = 50;
    _nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //球衣号码
    CGFloat numberX = nameX;
    CGFloat numberY = CGRectGetMaxY(_nameFrame) + paddding;
    CGFloat numberW = 120;
    CGFloat numberH = 50;
    _numbersFrame = CGRectMake(numberX, numberY, numberW, numberH);
    
    
    /**
     *  服役状态
     */
    CGFloat statuesX = nameX;
    CGFloat statuesY = CGRectGetMaxY(_numbersFrame) + paddding * 0.1;
    CGFloat statuesW = 100;
    CGFloat statuesH = 50;
    _statesFrame = CGRectMake(statuesX, statuesY, statuesW, statuesH);
    
    
    /**
     *  个人信息
     */
    CGFloat textX = paddding;
    CGFloat textY =CGRectGetMaxY(_iconFrame) + paddding;
    
    
    CGSize textRect= [self sizeWithText:self.enjoy.text font:EnjoyTextFont maxSize:CGSizeMake(280 , MAXFLOAT)];
    
    _textFrame = CGRectMake(textX, textY, textRect.width, textRect.height);
    
    
    _cellHeight = CGRectGetMaxY(self.textFrame) + paddding;
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    
   return  [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



@end
