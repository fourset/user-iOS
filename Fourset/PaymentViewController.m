//
//  PaymentViewController.m
//  Fourset
//
//  Created by Expert Software Dev on 9/9/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import "PaymentViewController.h"
#import "PromotionCodePopupViewController.h"
#import "CardCell.h"
#import "AppData.h"

#import "UIViewController+CWPopup.h"


@import iOS_Slide_Menu;

#define HEIGHT_CONTENT_VIEW 210.f

#define HEIGHT_CREDITCARD_CELL 50.f
#define HEIGHT_CREDITCARD_ADD_CELL 50.f
#define HEIGHT_PROMOTION_CELL 50.f
#define HEIGHT_PROMOTION_ADD_CELL 50.f


@interface PaymentViewController () <UITableViewDelegate, UITableViewDataSource, PromotionCodePopupDelegate, UIGestureRecognizerDelegate>{
    int nCreditCard, nPromotion;
}

@property (nonatomic, weak) IBOutlet UILabel                *lblCreditCards;
@property (nonatomic, weak) IBOutlet UILabel                *lblPromotion;

@property (nonatomic, weak) IBOutlet UITableView            *tblCards;
@property (nonatomic, weak) IBOutlet UITableView            *tblPromotions;

@property (nonatomic, weak) IBOutlet UIView                 *viewCardCellHeader;
@property (nonatomic, weak) IBOutlet UIView                 *viewPromotionCellHeader;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint     *heightForContentView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint     *heightForCreditCardTableView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint     *heightForPromotionTableView;

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    //Sample
    nCreditCard = 1;
    nPromotion = 2;
    
    //Update the UI according to the contents
    [self setupUI];
    
}


#pragma mark - Table Cell DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tblCards) {
        return 1;
    }
    else if (tableView == self.tblPromotions){
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tblCards) {
        return nCreditCard;
    }
    else if (tableView == self.tblPromotions){
        return nPromotion;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tblCards) {
        return HEIGHT_CREDITCARD_CELL;
    }
    else if (tableView == self.tblPromotions){
        return HEIGHT_PROMOTION_CELL;
    }
    
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"CardCell";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (tableView == self.tblCards) {
        cell.imgIcon.image = [UIImage imageNamed:@"green_visa_icon"];
        cell.lblText.text = @"Visa 2345*****";
    }
    else if (tableView == self.tblPromotions){
        cell.imgIcon.image = [UIImage imageNamed:@"grey_percent_icon"];
        cell.lblText.text = [NSString stringWithFormat:@"Promotion %d", (int)indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table Cell Data Delegate



#pragma mark - UI Setup

- (void)setupUI{
    //Update the labels with bottom lines
    [AppData setViewWithBottomBorder:self.lblCreditCards];
    [AppData setViewWithBottomBorder:self.lblPromotion];
    
    //Update the add buttons with bottom lines
    [AppData setViewWithBottomBorder:self.viewCardCellHeader withLeftOffset:15.f];
    [AppData setViewWithBottomBorder:self.viewPromotionCellHeader withLeftOffset:15.f];
    
    //Set the ADD buttons to both tables
    self.tblCards.tableHeaderView = self.viewCardCellHeader;
    self.tblPromotions.tableHeaderView = self.viewPromotionCellHeader;
    
    //Add tap gestures to ADD views
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnAddCreditCard:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = self;
    [self.viewCardCellHeader addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnAddPromotion:)];
    tapGesture1.numberOfTapsRequired = 1;
    tapGesture1.delegate = self;
    [self.viewPromotionCellHeader addGestureRecognizer:tapGesture1];
    
    //Allow background blur effect
    self.useBlurForPopup = YES;
    
    //Update the entire layout according to the number of credits and promotions
    [self updateLayout];
}

- (void)updateLayout{
    self.heightForCreditCardTableView.constant = HEIGHT_CREDITCARD_ADD_CELL + HEIGHT_CREDITCARD_CELL * nCreditCard;
    self.heightForPromotionTableView.constant = HEIGHT_PROMOTION_ADD_CELL + HEIGHT_PROMOTION_CELL * nPromotion;
    self.heightForContentView.constant = HEIGHT_CONTENT_VIEW + self.heightForCreditCardTableView.constant + self.heightForPromotionTableView.constant;
    
    [self.view layoutSubviews];
}

#pragma mark - User Interaction

- (IBAction)clickOnMenu:(id)sender{
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
}

- (IBAction)clickOnAddCreditCard:(id)sender{
    
}

- (IBAction)clickOnAddPromotion:(id)sender{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PromotionCodePopupViewController *promotionEnterVC = [storyBoard instantiateViewControllerWithIdentifier:@"PromotionEnterCodeVC"];
    promotionEnterVC.preferredContentSize = CGSizeMake(300., 200.);
    [promotionEnterVC.view setFrame:CGRectMake(0, 0, 300., 200.)];
    promotionEnterVC.delegate = self;
    [self presentPopupViewController:promotionEnterVC animated:YES completion:nil];
}

#pragma mark - PromotionCodePopupDelegate

-(void)clickConfirmBtn{
    if (self.popupViewController){
        [self dismissPopupViewControllerAnimated:YES completion:nil];
    }
}

-(void)clickCancelBtn{
    if (self.popupViewController){
        [self dismissPopupViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Slide Menu

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

@end
