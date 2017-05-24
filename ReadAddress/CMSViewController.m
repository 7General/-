//
//  CMSViewController.m
//  ReadAddress
//
//  Created by ZZG on 17/5/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CMSViewController.h"
#import <MessageUI/MessageUI.h>

@interface CMSViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation CMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(100, 100, 50, 50);
    rightBtn1.backgroundColor = [UIColor redColor];
    [rightBtn1 addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn1];

}


-(void)btnClick {
    NSLog(@"-----------------");
    
    
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = [NSArray arrayWithObject:@"15010206793"];
//        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"ooioioi"];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}



-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    switch (result) {
        case MessageComposeResultCancelled:
        {
            //click cancel button
        }
            break;
        case MessageComposeResultFailed:// send failed
            
            break;
            
        case MessageComposeResultSent:
        {
            //do something
        }
            break;
        default:
            break;
    } 
}


@end
