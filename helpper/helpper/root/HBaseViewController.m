//
//  HBaseViewViewController.m
//  helpper
//
//  Created by 🐷 on 16/3/21.
//  Copyright © 2016年 🐷. All rights reserved.
//


#import "HBaseViewController.h"
#import "HClockViewController.h"
#import "AFSoundManager.h"
#import "Utils.h"

#import "HSetClockViewController.h"
#import "AppDelegate.h"

@interface HBaseViewController ()

//@property (nonatomic,weak) AppDelegate *appdelegate;

@end

@implementation HBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clock:) name:@"clock" object:nil];
    
   
}

-(void)clock:(NSNotificationCenter *)not{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"起床" message:@"" delegate:nil cancelButtonTitle:@"再睡一会儿" otherButtonTitles:@"起床啦", nil];
    [alter show];
    
//    [self performSelector:@selector(paly) withObject:nil afterDelay:10];
    
    HSetClockViewController *setVC = [[HSetClockViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];

}

-(void)paly{
    [[AFSoundManager sharedManager]startPlayingLocalFileWithName:getBundleFile(@"guiz.mp3") andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    HClockViewController *clockVC = [[HClockViewController alloc]init];
//    
//    [self.navigationController pushViewController:clockVC animated:YES];
    
    
      EKEventStore *eventS  = [[EKEventStore alloc] init];
    
    NSDate *now = [NSDate date];
    
    //事件
    [eventS requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[now dateByAddingTimeInterval:30]];//30秒
            
            EKEvent *event = [EKEvent eventWithEventStore:eventS];
            event.title = @"This is a new event";
            event.startDate = now;
            event.endDate = [now dateByAddingTimeInterval:30];
            [event setAllDay:YES];
            [event addAlarm:alarm];
            [event setCalendar:[eventS defaultCalendarForNewEvents]];
            [eventS saveEvent:event span:EKSpanThisEvent commit:YES error:nil];
            
            NSError *err = nil;
            if([eventS saveEvent:event span:EKSpanThisEvent commit:YES error:&err]){
                NSLog(@"saved!");
            }else{
                NSLog(@"%@",err);
            }
        }else{
            NSLog(@"%@",error);
        }
    }];
    
    //提醒
    [eventS requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        if (granted) {
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[now dateByAddingTimeInterval:30]];
            
            EKReminder *reminder = [EKReminder reminderWithEventStore:eventS];
            reminder.title = @"This is a reminder";
            NSCalendar *cal = [NSCalendar currentCalendar];
            [cal setTimeZone:[NSTimeZone systemTimeZone]];
            NSInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit |
            NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit |
            NSSecondCalendarUnit;
            
            reminder.startDateComponents = [cal components:flags fromDate:[now dateByAddingTimeInterval:30]];//开始时间
            reminder.dueDateComponents = [cal components:flags fromDate:[now dateByAddingTimeInterval:30]]; //结束时间
            reminder.completionDate = [now dateByAddingTimeInterval:30];
            [reminder setCalendar:[eventS defaultCalendarForNewReminders]];
            reminder.priority = 1;//优先级
            [reminder addAlarm:alarm];
            
            NSError *err = nil;
            if([eventS saveReminder:reminder commit:YES error:&err]){
                NSLog(@"saved!");
            }else{
                NSLog(@"%@",err);
            }
        }else{
            NSLog(@"%@",error);
        }
    }];

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
