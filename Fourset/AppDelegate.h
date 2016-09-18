//
//  AppDelegate.h
//  Fourset
//
//  Created by Expert Software Dev on 9/8/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CLLocation *currentLocation;


@end

