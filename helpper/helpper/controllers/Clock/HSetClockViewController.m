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
#import "AppDelegate.h"

@interface HSetClockViewController ()<EKEventEditViewDelegate>

//@property (nonatomic,strong) EKEventStore *eventStore;

@property (nonatomic,weak) AppDelegate *appdelegate;

@end

@implementation HSetClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑提现";
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
//    self.eventStore  = [EKEventStore allocWithZone:<#(struct _NSZone *)#>];
    
    [self configer];
    
    self.appdelegate = [UIApplication sharedApplication].delegate;
    
}

- (void)configer{
    
//    self.appdelegate.eventManager.eventStore = [[EKEventStore alloc] init];
    
    NSDate *now = [NSDate date];
    
    //事件
    [self.appdelegate.eventManager.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[now dateByAddingTimeInterval:30]];//30秒
            
            EKEvent *event = [EKEvent eventWithEventStore:self.appdelegate.eventManager.eventStore];
            event.title = @"This is a new event";
            event.startDate = now;
            event.endDate = [now dateByAddingTimeInterval:30];
            [event setAllDay:YES];
            [event addAlarm:alarm];
            [event setCalendar:[self.appdelegate.eventManager.eventStore defaultCalendarForNewEvents]];
            [self.appdelegate.eventManager.eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:nil];
            
            NSError *err = nil;
            if([self.appdelegate.eventManager.eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err]){
                NSLog(@"saved!");
            }else{
                NSLog(@"%@",err);
            }
        }else{
            NSLog(@"%@",error);
        }
    }];
    
    //提醒
    [self.appdelegate.eventManager.eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        if (granted) {
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[now dateByAddingTimeInterval:30]];
            
            EKReminder *reminder = [EKReminder reminderWithEventStore:self.appdelegate.eventManager.eventStore];
            reminder.title = @"This is a reminder";
            NSCalendar *cal = [NSCalendar currentCalendar];
            [cal setTimeZone:[NSTimeZone systemTimeZone]];
            NSInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit |
            NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit |
            NSSecondCalendarUnit;
            
            reminder.startDateComponents = [cal components:flags fromDate:[now dateByAddingTimeInterval:30]];//开始时间
            reminder.dueDateComponents = [cal components:flags fromDate:[now dateByAddingTimeInterval:30]]; //结束时间
            reminder.completionDate = [now dateByAddingTimeInterval:30];
            [reminder setCalendar:[self.appdelegate.eventManager.eventStore defaultCalendarForNewReminders]];
            reminder.priority = 1;//优先级
            [reminder addAlarm:alarm];
            
            NSError *err = nil;
            if([self.appdelegate.eventManager.eventStore saveReminder:reminder commit:YES error:&err]){
                NSLog(@"saved!");
            }else{
                NSLog(@"%@",err);
            }
        }else{
            NSLog(@"%@",error);
        }
    }];
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
