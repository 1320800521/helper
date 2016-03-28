//
//  HClockViewController.m
//  helpper
//
//  Created by 🐷 on 16/3/21.
//  Copyright © 2016年 🐷. All rights reserved.
//

#import "HClockViewController.h"

@interface HClockViewController ()

@end

@implementation HClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self congigerClock];

}


/**
 *  设置闹钟
 */
-(void)congigerClock{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"clock" object:nil userInfo:@{@"name":@"起床"}];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
