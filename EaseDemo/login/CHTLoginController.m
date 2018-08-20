//
//  CHTLoginController.m
//  EaseDemo
//
//  Created by risenb_mac on 17/5/11.
//  Copyright © 2017年 CHT. All rights reserved.
//

#import "CHTLoginController.h"

@interface CHTLoginController ()

@property (weak, nonatomic) IBOutlet UITextField *acountField;
@property (weak, nonatomic) IBOutlet UITextField *secretField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation CHTLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    self.registBtn.layer.cornerRadius = 5;
    self.registBtn.layer.masksToBounds = YES;
    self.registBtn.layer.borderWidth = 1;
    self.registBtn.layer.borderColor = RGBColor(28, 151, 252, 1).CGColor;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    // Do any additional setup after loading the view from its nib.
}

- (void)tapAction {
    [self.view endEditing:YES];
}

- (IBAction)loginAction:(id)sender {
    [self.view endEditing:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.acountField.text password:self.secretField.text];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (!error) {
        [MBProgressHUD showHUDWithTitle:@"登录成功" addTo:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        });
    } else {
        [MBProgressHUD showHUDWithTitle:error.errorDescription addTo:self.view];
    }
    
}

- (IBAction)registAction:(id)sender {
    if (self.acountField.text.length < 2) {
        [MBProgressHUD showHUDWithTitle:@"账号不能少于2位" addTo:self.view];
        return;
    }
    if (self.secretField.text.length < 6) {
        [MBProgressHUD showHUDWithTitle:@"密码不能少于6位" addTo:self.view];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.acountField.text password:self.secretField.text];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (error==nil) {
        [MBProgressHUD showHUDWithTitle:@"注册成功" addTo:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loginAction:self.loginBtn];
        });
    } else {
        [MBProgressHUD showHUDWithTitle:error.errorDescription addTo:self.view];
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
