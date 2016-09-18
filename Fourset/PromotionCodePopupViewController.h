//
//  PromotionCodePopupViewController.h
//  Fourset
//
//  Created by Expert Software Dev on 9/9/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PromotionCodePopupDelegate <NSObject>

@optional
- (void)clickCancelBtn;
- (void)clickConfirmBtn;

@end

@interface PromotionCodePopupViewController : UIViewController

@property (nonatomic, weak) id <PromotionCodePopupDelegate> delegate;

@property (nonatomic, weak) IBOutlet UILabel            *lblTitle;
@property (nonatomic, weak) IBOutlet UITextField        *txtCode;
@property (nonatomic, weak) IBOutlet UIButton           *btnCancel;

@end
