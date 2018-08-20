//
//  CHTTabBarController.m
//  EaseDemo
//
//  Created by risenb_mac on 17/5/10.
//  Copyright © 2017年 CHT. All rights reserved.
//

#import "CHTTabBarController.h"
#import "CHTNaviController.h"
#import "CHTMainController.h"
#import "CHTContactController.h"
#import "CHTDynamicController.h"

@interface CHTTabBarController ()<EMContactManagerDelegate>

@property (nonatomic, assign) NSInteger itemTag;

@end

@implementation CHTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemTag = 0;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSFontAttributeName:[UIFont boldSystemFontOfSize:10]}  forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:topicColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:10]}  forState:UIControlStateSelected];
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;    [self addChildController:[[CHTMainController alloc] init] WithName:@"消息" icon:@"" selectedIcon:@""];
    [self addChildController:[[CHTContactController alloc] init] WithName:@"联系人" icon:@"" selectedIcon:@""];
    [self addChildController:[[CHTDynamicController alloc] init] WithName:@"动态" icon:@"" selectedIcon:@""];
    [self.tabBar setTintColor:[UIColor redColor]];
    
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    // Do any additional setup after loading the view.
}

- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage {
    
}

- (void)addChildController:(UIViewController *)controller WithName:(NSString *)name icon:(NSString *)iconName selectedIcon:(NSString *)selectedIconName {
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:name image:[UIImage imageNamed:iconName] selectedImage:[UIImage imageNamed:selectedIconName]];
    CHTNaviController *nvc = [[CHTNaviController alloc] initWithRootViewController:controller];
    item.tag = self.itemTag++;
    nvc.tabBarItem = item;
    [self addChildViewController:nvc];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition:NO animated:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
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
