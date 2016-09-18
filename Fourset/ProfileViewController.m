//
//  ProfileViewController.m
//  Fourset
//
//  Created by Expert Software Dev on 9/9/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import "ProfileViewController.h"
#import "CardCell.h"
#import "AppData.h"

@import iOS_Slide_Menu;
@import MGSwipeTableCell;

#define HEIGHT_PLACE_CELL 50.f
#define HEIGHT_CONTENT_VIEW  360.f

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>{
    int nPlaces;
}

@property (nonatomic, weak) IBOutlet UITableView            *tblPlaces;
@property (nonatomic, weak) IBOutlet UILabel                *lblProfileDetails;
@property (nonatomic, weak) IBOutlet UILabel                *lblSavedPlaces;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint     *heightForPlacesTableView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint     *heightForContentView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    nPlaces = 3;
    
    [self setupUI];
}


#pragma mark - UI Setup

- (void)updateLayout{
    self.heightForPlacesTableView.constant = HEIGHT_PLACE_CELL * nPlaces;
    self.heightForContentView.constant = HEIGHT_CONTENT_VIEW + self.heightForPlacesTableView.constant;
    
    [self.view layoutSubviews];
}


- (void)setupUI{
    //Update the labels with bottom lines
    [AppData setViewWithBottomBorder:self.lblProfileDetails];
    [AppData setViewWithBottomBorder:self.lblSavedPlaces];
    
    //Update the swipe smooth
    self.tblPlaces.allowsMultipleSelectionDuringEditing = NO;
    
    //Update layout according to the places count
    [self updateLayout];
}


#pragma mark - Table Cell DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return nPlaces;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_PLACE_CELL;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"CardCell";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.imgIcon.image = [UIImage imageNamed:@"place_left_icon"];
    cell.lblText.text = [NSString stringWithFormat:@"Place Address %d", (int)indexPath.row];
    
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"   Delete"
                                                    icon:[UIImage imageNamed:@"recyle_icon"]
                                         backgroundColor:FS_GREEN
                                                 padding:30.]];
    cell.rightSwipeSettings.transition = MGSwipeTransitionStatic;
    
    return cell;
}

//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    // you need to implement this method too or nothing will work:
//    
//}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}


#pragma mark - User Interaction

- (IBAction)clickOnMenu:(id)sender{
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
}

#pragma mark - Slide Menu

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}



@end
