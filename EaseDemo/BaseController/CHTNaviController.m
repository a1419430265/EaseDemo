//
//  CHTNaviController.m
//  EaseDemo
//
//  Created by risenb_mac on 17/5/10.
//  Copyright © 2017年 CHT. All rights reserved.
//

#import "CHTNaviController.h"

@interface CHTNaviController ()

@end

@implementation CHTNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
//    self.navigationBar.backgroundColor = topicColor;
    self.navigationBar.translucent = YES;
    UIImage *image = [UIImage imageNamed:@"naviBarBack"];
//    image.size
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.interactivePopGestureRecognizer.enabled = YES;
    self.navigationBar.tintColor = [UIColor colorWithWhite:0.98 alpha:1];
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithWhite:0.98 alpha:1]};
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
