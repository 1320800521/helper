//
//  AppDelegate.m
//  helpper
//
//  Created by 🐷 on 16/3/21.
//  Copyright © 2016年 🐷. All rights reserved.
//

#import "AppDelegate.h"
#import "HClockViewController.h"
#import "HBaseViewController.h"
#import "NavViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+(AppDelegate *)shareDelegate{
    AppDelegate *delegate =(id)[[UIApplication sharedApplication] delegate];
    return delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.eventManager = [[EventManager alloc]init];
    
    [self.eventManager.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (error == nil) {
            // Store the returned granted value.
            self.eventManager.eventsAccessGranted = granted;
        }
        else{
            
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    
    HBaseViewController *root = [[HBaseViewController alloc]init];
    NavViewController *nav = [[NavViewController alloc]initWithRootViewController:root];
    self.window.rootViewController = nav;
    
    
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    return YES;
}



/**
 * 注册用户通知设置
 */
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

/**
 * 获取deviceToken
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    
}

- (void)onlineConfigCallBack:(NSNotification *)note {

}

/**
 * 远程通知
 */
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {

}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    
}


- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     * 统计推送打开率3
     */
    
    //震动
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    AudioServicesPlaySystemSound(1007);
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"起床" message:@"起床了" delegate:nil cancelButtonTitle:@"再睡一会儿" otherButtonTitles:@"好", nil];
    [alter show];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
