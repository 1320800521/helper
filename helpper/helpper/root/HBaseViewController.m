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

@interface HBaseViewController ()

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
    HClockViewController *clockVC = [[HClockViewController alloc]init];
    
    [self.navigationController pushViewController:clockVC animated:YES];
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
