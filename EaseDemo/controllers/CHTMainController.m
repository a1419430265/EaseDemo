//
//  CHTMainController.m
//  EaseDemo
//
//  Created by risenb_mac on 17/5/11.
//  Copyright © 2017年 CHT. All rights reserved.
//

#import "CHTMainController.h"

@interface CHTMainController ()

@end

@implementation CHTMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(layoutAction)];
}

- (void)layoutAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutAction" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    if (![EMClient sharedClient].isLoggedIn) {
        CHTNaviController *nvc = [[CHTNaviController alloc] initWithRootViewController:[[CHTLoginController alloc] initWithNibName:@"CHTLoginController" bundle:nil]];
        [self.navigationController.tabBarController presentViewController:nvc animated:YES completion:nil];
    }
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
