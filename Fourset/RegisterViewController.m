//
//  RegisterViewController.m
//  Fourset
//
//  Created by Expert Software Dev on 9/8/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppData.h"

@import SkyFloatingLabelTextField;
@import IQKeyboardManager;

@interface RegisterViewController ()

@property (nonatomic, weak) IBOutlet SkyFloatingLabelTextField * txtFullName;
@property (nonatomic, weak) IBOutlet SkyFloatingLabelTextField * txtMobile;
@property (nonatomic, weak) IBOutlet SkyFloatingLabelTextField * txtEmail;
@property (nonatomic, weak) IBOutlet SkyFloatingLabelTextField * txtPassword;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - User Interaction
- (IBAction)backToHome:(id)segue{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)clickRegister:(id)sender {
    [AppData goToMainVC];
}

@end
