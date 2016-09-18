//
//  SideMenuViewController.m
//  Fourset
//
//  Created by Expert Software Dev on 9/8/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SlideNavigationController.h"
#import "AppData.h"

@interface SideMenuViewController ()
{
    UIButton *btnSelected;
}

@property (nonatomic, weak) IBOutlet UILabel            *lblName;
@property (nonatomic, weak) IBOutlet UILabel            *lblEmail;

@property (nonatomic, weak) IBOutlet UIButton           *btnHome;
@property (nonatomic, weak) IBOutlet UIButton           *btnProfile;
@property (nonatomic, weak) IBOutlet UIButton           *btnPayment;
@property (nonatomic, weak) IBOutlet UIButton           *btnHistory;
@property (nonatomic, weak) IBOutlet UIButton           *btnAbout;
@property (nonatomic, weak) IBOutlet UIButton           *btnSupport;
@property (nonatomic, weak) IBOutlet UIButton           *btnLogout;



@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self defaultSetup];
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
#pragma mark - Setup UI

- (void)defaultSetup{
    //Choose the first menu - Home
    _btnHome.selected = YES;
    btnSelected = self.btnHome;
}

- (void)updateMenuUI:(UIButton *)btn{
    if (btnSelected && btnSelected != btn) {
        btnSelected.selected = NO;
    }
    
    btnSelected = btn;
    btnSelected.selected = YES;
    
}

#pragma mark - User Interaction
- (IBAction)clickOnMenu:(id)sender{
    [self updateMenuUI:sender];

    UIButton *btnMenu = (UIButton*)sender;
    if (btnMenu == _btnHome){
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *mapVC = [storyBoard instantiateViewControllerWithIdentifier:@"MapVC"];
        
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:mapVC
                                                                        withCompletion:nil];
    }
    else if (btnMenu == _btnProfile){
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *profileVC = [storyBoard instantiateViewControllerWithIdentifier:@"ProfileVC"];
        
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:profileVC
                                                                        withCompletion:nil];

    }
    else if (btnMenu == _btnPayment){
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *paymentVC = [storyBoard instantiateViewControllerWithIdentifier:@"PaymentVC"];
        
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:paymentVC
                                                                        withCompletion:nil];
        
    }
    else if (btnMenu == _btnLogout){
        [AppData logOut];
    }
    
    
}

@end
