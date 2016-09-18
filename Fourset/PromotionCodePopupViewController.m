//
//  PromotionCodePopupViewController.m
//  Fourset
//
//  Created by Expert Software Dev on 9/9/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import "PromotionCodePopupViewController.h"
#import "AppData.h"

#import "UIViewController+CWPopup.h"

@implementation PromotionCodePopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    //Update the UI according to the contents
    [self setupUI];
    
}

#pragma mark - User Interaction

- (IBAction)clickOnCancel:(id)sender{
    if (self.delegate) {
        [self.delegate clickCancelBtn];
    }
}

- (IBAction)clickOnConfirm:(id)sender{
    if (self.delegate) {
        [self.delegate clickConfirmBtn];
    }
}

#pragma mark - UI Setup

- (void)setupUI{
    [AppData setViewWithBottomBorder:self.lblTitle];
    [AppData setViewWithBottomBorder:self.txtCode];
    
    [AppData setViewWithTopBorder:self.btnCancel withLeftOffset:0];
}


@end
