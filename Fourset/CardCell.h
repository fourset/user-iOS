//
//  CardCell.h
//  Fourset
//
//  Created by Expert Software Dev on 9/9/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MGSwipeTableCell;

@interface CardCell : MGSwipeTableCell//UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *lblText;
@property(nonatomic, weak) IBOutlet UIImageView *imgIcon;

@end
