//
//  mainViewControllerDelegate.h
//  enjoyTechTable
//
//  Created by lanou3g on 15/7/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
@class enjoyFooteView;

@protocol mainViewControllerDelegate <NSObject>

- (void)enjoyFootViewDidClickLoadButton:(enjoyFooteView *)footView;

@end
