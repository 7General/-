//
//  PopTableView.h
//  ReadAddress
//
//  Created by hzbj on 17/5/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


/*! 水平间距边距 */
UIKIT_EXTERN CGFloat const PopTableViewContentHeight;

@class PopTableView;
@protocol PopTableViewDelegate <NSObject>
@required
/*! 左数据源 */
-(NSMutableArray *)popLeftTableView:(PopTableView *)popView;
/*! 右数据源 */
-(NSMutableArray *)popRightTableView:(PopTableView *)popView;

@optional
-(void)popTableView:(PopTableView *)popView didSelectIndexPath:(NSIndexPath *)indexPath;
@end


@interface PopTableView : UIView

-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)height;

- (void)show;
- (void)dismissThePopView;

@property (nonatomic, weak) id<PopTableViewDelegate>  dataSource;

@end
