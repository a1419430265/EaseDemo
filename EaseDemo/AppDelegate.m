//
//  AppDelegate.m
//  EaseDemo
//
//  Created by risenb_mac on 17/5/10.
//  Copyright © 2017年 CHT. All rights reserved.
//

#import "AppDelegate.h"
#import "CHTTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = [[CHTTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    EMOptions *options = [EMOptions optionsWithAppkey:EaseAppKey];
    options.apnsCertName = EaseAppApnsName;
    NSLog(EaseAppApnsName);
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutAction) name:@"logoutAction" object:nil];
    // Override point for customization after application launch.
    return YES;
}

- (void)layoutAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __block EMError *error = nil;
        [MBProgressHUD showHUDAddedTo:self.window action:^{
            error = [[EMClient sharedClient] logout:YES];
        }];
        if (!error) {
            [MBProgressHUD showHUDWithTitle:@"退出成功" addTo:self.window];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self layoutSuccess];
            });
        } else {
            [MBProgressHUD showHUDWithTitle:error.errorDescription addTo:self.window];
        }
    }]];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


- (void)layoutSuccess {
    CHTLoginController *lvc = [[CHTLoginController alloc] initWithNibName:@"CHTLoginController" bundle:nil];
    [self.window.rootViewController presentViewController:[[CHTNaviController alloc] initWithRootViewController:lvc] animated:YES completion:^{
        ((UITabBarController *)self.window.rootViewController).selectedIndex = 0;
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];

    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
