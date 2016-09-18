//
//  AppData.m
//  Fourset
//
//  Created by Expert Software Dev on 9/12/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//


#import "AppData.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SideMenuViewController.h"

@import iOS_Slide_Menu;

@import Reachability;

static AppData * instance;

@implementation AppData
{
    NSUserDefaults * _userDefaults;
    Reachability *_reachability;
}

@synthesize latitude, longitude;

+ (AppData *)appData{
    static AppData *sharedMyAppData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyAppData = [[self alloc] init];
    });
    return sharedMyAppData;
}

- (id)init{
    self = [super init];
    if (self){
        _userDefaults = [NSUserDefaults standardUserDefaults];
        
        _isLoggedIn = NO;
        
        _reachability = [Reachability reachabilityWithHostname:[self getBaseUrl]];
        [_reachability startNotifier];
    }
    return self;
}


#pragma mark - Label
- (CGFloat)getActualFontSizeForLabel:(UILabel *)label
{
    NSStringDrawingContext *labelContext = [NSStringDrawingContext new];
    labelContext.minimumScaleFactor = label.minimumScaleFactor;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:label.text attributes:@{ NSFontAttributeName: label.font }];
    [attributedString boundingRectWithSize:label.frame.size
                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                   context:labelContext];
    
    CGFloat actualFontSize = label.font.pointSize * labelContext.actualScaleFactor;
    return actualFontSize;
}

#pragma mark - globa preferences

- (NSString *)username{
    return [_userDefaults objectForKey:@"username"];
}
- (void)setUsername:(NSString *)username{
    [_userDefaults setObject:username forKey:@"username"];
    [_userDefaults synchronize];
}

- (NSString *)firstname{
    return [_userDefaults objectForKey:@"firstname"];
}
- (void)setFirstname:(NSString *)firstname{
    [_userDefaults setObject:firstname forKey:@"firstname"];
    [_userDefaults synchronize];
}

- (NSString *)lastname{
    return [_userDefaults objectForKey:@"lastname"];
}
- (void)setLastname:(NSString *)lastname{
    [_userDefaults setObject:lastname forKey:@"lastname"];
    [_userDefaults synchronize];
}

- (NSString *)userAccessToken{
    return [_userDefaults objectForKey:@"userAccessToken"];
}

- (void)setUserAccessToken:(NSString*)userAccessToken{
    [_userDefaults setObject:userAccessToken forKey:@"userAccessToken"];
    [_userDefaults synchronize];
}

#pragma mark - globa function


-(NSString *)apiKey{
    return API_KEY;
}

- (NSString *)getBaseUrl{
    if (DEVEL_SERVER){
        return BASEURL_DEVEL;
    }
    else{
        return BASEURL_PROD;
    }
}

- (BOOL)wifiAvaiable{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        //No internet
        return NO;
    }
    else if (status == ReachableViaWiFi)
    {
        //WiFi
        return YES;
    }
    else if (status == ReachableViaWWAN)
    {
        //3G
        return YES;
    }
    
    return NO;
    
    /*
    if ([_reachability isReachable]) {
        return YES;
    }
    
    if ([_reachability isReachableViaWiFi]) {
        return YES;
    }
    
    if ([_reachability isReachableViaWWAN]) {
        return YES;
    }
    
    if ([_reachability currentReachabilityStatus] == ReachableViaWWAN){
        return YES;
    }
    if ([_reachability currentReachabilityStatus] == ReachableViaWiFi){
        return YES;
    }
    
    return NO;
    */
}

#pragma mark - TextField Text Validation

+ (BOOL)isFieldEmpty:(UITextField *)field{
    if ([field.text length] > 0){
        return NO;
    }
    else{
        return YES;
    }
}


+ (BOOL)isFieldEmail:(UITextField *)field{
    NSString * mail = field.text;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailText = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailText evaluateWithObject:mail];
}

#pragma mark - TextField Customization

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (void)setTextFieldBordersWhite:(UITextField *)f withLeftImage:(UIImage *)imgLeft {
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       CALayer *bottomBorder = [CALayer layer];
                       bottomBorder.frame =
                       CGRectMake(0.0f, f.frame.size.height - 1, f.frame.size.width, 0.5f);
                       bottomBorder.backgroundColor =
                       [UIColor whiteColor].CGColor;
                       [f.layer addSublayer:bottomBorder];
                       [f setFont:NORMAL_FS_FONT(f.font.pointSize)];
                       [f setValue:[UIColor colorWithRed:179.0/255.0 green:173.0/255.0 blue:172.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                   });
    
    if (imgLeft) {
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:imgLeft];
        
        [leftImageView setFrame:CGRectMake(0, 5, 18, 18)];
        [leftImageView setTintColor:[UIColor whiteColor]];
        [leftImageView setContentMode:UIViewContentModeScaleAspectFit];
        [leftImageView setClipsToBounds:YES];
        
        UIView *v = [[UIView alloc]
                     initWithFrame:CGRectMake(0, 0, 35, f.frame.size.height)];
        [v addSubview:leftImageView];
        [f setLeftView:v];
        [f setLeftViewMode:UITextFieldViewModeAlways];
    }
}


+ (void)setTextFieldBordersRed:(UITextField *)f withLeftImage:(UIImage *)imgLeft {
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       CALayer *bottomBorder = [CALayer layer];
                       bottomBorder.frame =
                       CGRectMake(0.0f, f.frame.size.height - 1, f.frame.size.width, 0.5f);
                       bottomBorder.backgroundColor =
                       FS_BLUE.CGColor;
                       [f.layer addSublayer:bottomBorder];
                       [f setFont:NORMAL_FS_FONT(f.font.pointSize)];
                       [f setValue:[UIColor colorWithRed:179.0/255.0 green:173.0/255.0 blue:172.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                   });
    
    if (imgLeft) {
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:imgLeft];
        
        [leftImageView setFrame:CGRectMake(0, 5, 18, 18)];
        [leftImageView setTintColor:FS_BLUE];
        [leftImageView setContentMode:UIViewContentModeScaleAspectFit];
        [leftImageView setClipsToBounds:YES];
        
        UIView *v = [[UIView alloc]
                     initWithFrame:CGRectMake(0, 0, 35, f.frame.size.height)];
        [v addSubview:leftImageView];
        [f setLeftView:v];
        [f setLeftViewMode:UITextFieldViewModeAlways];
    }
}


+ (void)setTextFieldBorders:(UITextField *)f withLeftImage:(UIImage *)imgLeft {
    [AppData setTextFieldBorders:f withLeftImage:imgLeft withLeftImageColor:nil];
}

+ (void)setTextFieldBorders:(UITextField *)f withLeftImage:(UIImage *)imgLeft withLeftImageColor:(UIColor*)color{
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       CALayer *bottomBorder = [CALayer layer];
                       bottomBorder.frame =
                       CGRectMake(0.0f, f.frame.size.height - 1, f.frame.size.width, 0.5f);
                       bottomBorder.backgroundColor =
                       [UIColor colorWithRed:.72 green:.72 blue:.72 alpha:0.5].CGColor;
                       [f.layer addSublayer:bottomBorder];
                       [f setFont:NORMAL_FS_FONT(f.font.pointSize)];
                   });
    
    if (imgLeft) {
        float height = f.frame.size.height;
        float width = height;
        float offset = 10.f;
        
        
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:imgLeft];
        [leftImageView setFrame:CGRectMake(offset, offset, width - offset * 2.0, height - offset * 2.0)];
        
        if (color) [leftImageView setTintColor:color];
        
        [leftImageView setContentMode:UIViewContentModeScaleAspectFit];
        [leftImageView setClipsToBounds:YES];
        
        UIView *v = [[UIView alloc]
                     initWithFrame:CGRectMake(0, 0, width, height)];
        [v addSubview:leftImageView];
        [f setLeftView:v];
        [f setLeftViewMode:UITextFieldViewModeAlways];
    }
}



+ (void)setTextFieldLessBorders:(UITextField *)f withLeftImage:(UIImage *)imgLeft {
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       CALayer *bottomBorder = [CALayer layer];
                       bottomBorder.frame =
                       CGRectMake(25.f, f.frame.size.height - 1, f.frame.size.width - 25.f, 0.5f);
                       bottomBorder.backgroundColor =
                       [UIColor colorWithRed:.72 green:.72 blue:.72 alpha:0.5].CGColor;
                       [f.layer addSublayer:bottomBorder];
                       [f setFont:NORMAL_FS_FONT(f.font.pointSize)];
                   });
    
    if (imgLeft) {
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:imgLeft];
        
        [leftImageView setFrame:CGRectMake(0, 5, 18, 18)];
        [leftImageView setTintColor:FS_BLUE];
        [leftImageView setContentMode:UIViewContentModeScaleAspectFit];
        [leftImageView setClipsToBounds:YES];
        
        UIView *v = [[UIView alloc]
                     initWithFrame:CGRectMake(0, 0, 35, f.frame.size.height)];
        [v addSubview:leftImageView];
        [f setLeftView:v];
        [f setLeftViewMode:UITextFieldViewModeAlways];
    }
}

+ (void)setTextFieldWithoutBorders:(UITextField *)f withLeftImage:(UIImage *)imgLeft withColor:(UIColor*)color{
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [f setFont:NORMAL_FS_FONT(f.font.pointSize)];
                   });
    
    if (imgLeft) {
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:imgLeft];
        
        [leftImageView setFrame:CGRectMake(0, 5, 18, 18)];
        
        if (color)
            [leftImageView setTintColor:color];
        
        [leftImageView setContentMode:UIViewContentModeScaleAspectFit];
        [leftImageView setClipsToBounds:YES];
        
        UIView *v = [[UIView alloc]
                     initWithFrame:CGRectMake(0, 0, 35, f.frame.size.height)];
        [v addSubview:leftImageView];
        [f setLeftView:v];
        [f setLeftViewMode:UITextFieldViewModeAlways];
    }
}



+ (void)setViewWithBottomBorder:(UIView *)f{
    [self setViewWithBottomBorder:f withLeftOffset:0];
}

+ (void)setViewWithBottomBorder:(UIView *)f withLeftOffset:(float)leftOffset{
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       CALayer *bottomBorder = [CALayer layer];
                       bottomBorder.frame =
                       CGRectMake(leftOffset, f.frame.size.height - 1, f.frame.size.width - leftOffset, 0.5f);
                       bottomBorder.backgroundColor =
                       [UIColor colorWithRed:.72 green:.72 blue:.72 alpha:0.5].CGColor;
                       [f.layer addSublayer:bottomBorder];
                   });
    
}

+ (void)setViewWithTopBorder:(UIView *)f withLeftOffset:(float)leftOffset{
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       CALayer *bottomBorder = [CALayer layer];
                       bottomBorder.frame =
                       CGRectMake(leftOffset, 0, f.frame.size.width - leftOffset, 0.5f);
                       bottomBorder.backgroundColor =
                       FS_DARK.CGColor;
                       [f.layer addSublayer:bottomBorder];
                   });
    
}


#pragma mark - UI Navigation

+ (void)logOut {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navController = [storyBoard instantiateInitialViewController];
    
    FoursetAppDelegate.window.rootViewController = navController;
    [UIView transitionWithView:FoursetAppDelegate.window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
}

+ (void)goToMainVC {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SlideNavigationController *navigationController = [storyBoard instantiateViewControllerWithIdentifier:@"MainStartNav"];
    SideMenuViewController *leftMenuVC = [storyBoard instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    [SlideNavigationController sharedInstance].leftMenu = leftMenuVC;
    [SlideNavigationController sharedInstance].rightMenu = [UIViewController new];
    
    float screenWidth = CGRectGetWidth(FoursetAppDelegate.window.bounds);
    [SlideNavigationController sharedInstance].portraitSlideOffset = screenWidth - 199.;
    
    FoursetAppDelegate.window.rootViewController = navigationController;
    [UIView transitionWithView:FoursetAppDelegate.window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
}

@end
