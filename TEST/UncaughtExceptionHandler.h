//
//  UncaughtExceptionHandler.h
//  cHeathKit
//
//  Created by hzbj on 17/7/27.
//  Copyright © 2017年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject
{
    BOOL dismissed;
}

void InstallUncaughtExceptionHandler();

@end
