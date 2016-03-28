//
//  HSetClockViewController.m
//  helpper
//
//  Created by 🐷 on 16/3/23.
//  Copyright © 2016年 🐷. All rights reserved.
//

#import "HSetClockViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface HSetClockViewController ()<EKEventEditViewDelegate>

@property (nonatomic,strong) EKEventStore *eventStore;

@end

@implementation HSetClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑提现";
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
//    self.eventStore  = [EKEventStore allocWithZone:<#(struct _NSZone *)#>];
    
    
}

- (void)configer{
    
//    EKEventEditViewController *editVC = [[EKEventEditViewController alloc]init];
//    
////    editVC.eventStore = self
//    editVC.editViewDelegate = self;
//    [self presentViewController:editVC animated:YES completion:^{}];
}

- (void)eventEditViewController:(EKEventEditViewController *)controller
          didCompleteWithAction:(EKEventEditViewAction)action
{
//    HSetClockViewController * __weak weakSelf = self;
    // Dismiss the modal view controller
    [self dismissViewControllerAnimated:YES completion:^
     {
         if (action != EKEventEditViewActionCanceled)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 // Re-fetch all events happening in the next 24 hours
//                 weakSelf.eventsList = [self fetchEvents];
//                 // Update the UI with the above events
//                 [weakSelf.tableView reloadData];
             });
         }
     }];
    
}


- (void)edit{
    EKEventEditViewController *editVC = [[EKEventEditViewController alloc]init];
    
    //    editVC.eventStore = self
    editVC.editViewDelegate = self;
    [self presentViewController:editVC animated:YES completion:^{}];

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
