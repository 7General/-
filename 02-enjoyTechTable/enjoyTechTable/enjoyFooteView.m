//
//  enjoyFooteView.m
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "enjoyFooteView.h"



@interface enjoyFooteView()
@property (weak, nonatomic) IBOutlet UIButton *loadButton;


@property (weak, nonatomic) IBOutlet UIView *laodView;
- (IBAction)btnLoad:(UIButton *)sender;


@end






@implementation enjoyFooteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/**
 *  快速创建一个footview对象
 *
 *  @return <#return value description#>
 */
+ (instancetype)footerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FooterView" owner:nil options:nil]  lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



/**
 *  特别提醒,如果想让菊花旋转起来  可以在属性栏 把behavior全部打钩即可
 */




- (IBAction)btnLoad:(UIButton *)sender {
    /**
     *  隐藏加载更多按钮
     */
    self.loadButton.hidden = YES;
    self.laodView.hidden = NO;
    
    /**
     刷新更多数据
     *  c 语言中的延迟加载,纯c语言结构  
     同等//[self performSelector:<#(SEL)#> withObject:<#(id)#> afterDelay:<#(NSTimeInterval)#>];
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        /**
         * 判断代理是否实现
         *
         */
        if ([self.delegate respondsToSelector:@selector(enjoyFootViewDidClickLoadButton:)]) {
            /**
             *  利用代理加载更多数据
             */
            [self.delegate enjoyFootViewDidClickLoadButton:self];
            
            /**
             *  设置foot按钮状态
             */
            self.laodView.hidden = YES;
            self.loadButton.hidden = NO;
        }
        
        
    });
}
@end
