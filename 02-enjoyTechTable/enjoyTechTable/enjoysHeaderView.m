//
//  enjoysHeaderView.m
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#define imageCount 6
#import "enjoysHeaderView.h"

@interface enjoysHeaderView()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *imagePage;



@end




@implementation enjoysHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (instancetype)enjoysHeader
{
    return [[[NSBundle mainBundle]loadNibNamed:@"enjoyHeaderView" owner:nil options:nil]lastObject];
}



- (void)awakeFromNib
{
    
    CGFloat imageX = 0;
    CGFloat imageY = 5;
    
    for (int index = 0; index < 6; index++) {
        CGFloat offset = index * self.imageScrollView.frame.size.width;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX + offset, imageY, self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"k%d.jpg",index]];
        
        [self.imageScrollView addSubview:imageView];
    }
    self.imageScrollView.contentSize = CGSizeMake(imageCount * self.imageScrollView.frame.size.width, 0);
    self.imageScrollView.pagingEnabled =YES;
    
    
    
    self.imagePage.numberOfPages = imageCount;
    
    /**
     *  设置代理
     */
    self.imageScrollView.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 self.imagePage.currentPage = (self.imageScrollView.contentOffset.x + (self.imageScrollView.frame.size.width * 0.5)) / self.imageScrollView.frame.size.width;
}






















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
