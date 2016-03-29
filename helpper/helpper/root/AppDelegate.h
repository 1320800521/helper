//
//  AppDelegate.h
//  helpper
//
//  Created by 🐷 on 16/3/21.
//  Copyright © 2016年 🐷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) EventManager *eventManager;

+(AppDelegate *)shareDelegate;

@end

