//
//  WakeAddressViewController.m
//  ReadAddress
//
//  Created by admin on 17/5/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "WakeAddressViewController.h"

#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>

@interface WakeAddressViewController ()<ABPeoplePickerNavigationControllerDelegate>

@end

@implementation WakeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 100, 100, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"唤醒通讯录界面" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(wakeAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)wakeAddress {
    [self readAddress];
}

-(void)readAddress {
    NSInteger phoneVersion = [[[UIDevice currentDevice] systemVersion] integerValue];
    ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
    nav.peoplePickerDelegate = self;
    if(phoneVersion > 8){
        nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    }
    [self presentViewController:nav animated:YES completion:nil];
    
}

//取消选择
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    
    if ([phoneNO hasPrefix:@"+"]) {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    
        phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (phoneNO) {
        NSLog(@"--------------%@",phoneNO);
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }
    //    NSLog(@"%@", phoneNO);
    //    if (phone && [ZXValidateHelper checkTel:phoneNO]) {
    //phoneNum = phoneNO;
    //[self.tableView reloadData];
    //
    //        return;
    //    }
    
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person {
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}


@end
