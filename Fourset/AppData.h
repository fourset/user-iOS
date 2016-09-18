//
//  AppData.h
//  Fourset
//
//  Created by Expert Software Dev on 9/12/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface AppData : NSObject

@property double latitude;
@property double longitude;
@property BOOL   isLoggedIn;

+ (AppData *)appData;

/* -------------- User Information ----------------- */

- (NSString *)username;
- (void)setUsername:(NSString *)username;

- (NSString *)firstname;
- (void)setFirstname:(NSString *)firstname;

- (NSString *)lastname;
- (void)setLastname:(NSString *)lastname;

- (NSString *)userAccessToken;
- (void)setUserAccessToken:(NSString*)userAccessToken;

/* -------------- API Reference ----------------- */

- (NSString *)getBaseUrl;
- (BOOL)wifiAvaiable;

/* -------------- Font Label ----------------- */
- (CGFloat)getActualFontSizeForLabel:(UILabel *)label;

/* -------------- TextField Validation ----------------- */

+ (BOOL)isFieldEmpty:(UITextField *)field;
+ (BOOL)isFieldEmail:(UITextField *)field;

/* -------------- Text Field Customization ----------------- */

+ (void)setTextFieldBorders:(UITextField *)f withLeftImage:(UIImage *)imgLeft;
+ (void)setTextFieldBorders:(UITextField *)f withLeftImage:(UIImage *)imgLeft withLeftImageColor:(UIColor*)color;

+ (void)setViewWithBottomBorder:(UIView *)f;
+ (void)setViewWithBottomBorder:(UIView *)f withLeftOffset:(float)leftOffset;

+ (void)setViewWithTopBorder:(UIView *)f withLeftOffset:(float)leftOffset;

/* -------------- UI navigation ----------------- */
+ (void)logOut;
+ (void)goToMainVC;

@end
