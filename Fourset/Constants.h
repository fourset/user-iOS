//
//  Constants.h
//  Fourset
//
//  Created by Expert Software Dev on 9/9/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */

/*------------------------------    App Delegate  ----------------------------------*/

#define FoursetAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/*------------------------------    API calls  ----------------------------------*/

static NSString * const API_KEY       = @"15U1U29p42mG0914h7148376qdlV8n1j";
static NSString * const BASEURL_PROD  = @"https://api.fourset.com";
static NSString * const BASEURL_DEVEL = @"https://test-api.fourset.com";
static const BOOL DEVEL_SERVER  = NO;
 

/*------------------------------    Font  ----------------------------------*/

#define SEMIBOLD_FS_FONT(s) [UIFont fontWithName:@"OpenSans-Semibold" size:s]
#define LIGHT_FS_FONT(s) [UIFont fontWithName:@"OpenSans-Light" size:s]
#define NORMAL_FS_FONT(s) [UIFont fontWithName:@"OpenSans" size:s]
#define BOLD_FS_FONT(s) [UIFont fontWithName:@"OpenSans-Bold" size:s]

/*------------------------------    Color  ----------------------------------*/

#define FS_BLUE [UIColor colorWithRed:16./255.0 green:119./255.0 blue:170./255.0 alpha:1.0]
#define FS_DARK [UIColor colorWithRed:40./255.0 green:40./255.0 blue:40./255.0 alpha:1.0]
#define FS_GREY [UIColor colorWithRed:95./255. green:95./255. blue:95./255. alpha:1.0]
#define FS_GREEN [UIColor colorWithRed:40./255. green:161./255. blue:55./255. alpha:1.0]