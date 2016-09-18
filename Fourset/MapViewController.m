//
//  MapViewController.m
//  Fourset
//
//  Created by Expert Software Dev on 9/8/16.
//  Copyright © 2016 Fourset Inc. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"
#import "AppData.h"

@import iOS_Slide_Menu;
@import SkyFloatingLabelTextField;

@interface MapViewController () <SlideNavigationControllerDelegate, GMSMapViewDelegate>{
    GMSMapView *mapView;
    
    CLLocation *currentUserLocation;
}

@property (nonatomic, weak) IBOutlet UIView *mapContainerView;

@property (nonatomic, weak) IBOutlet UITextField *searchTextField;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Set current user
    currentUserLocation = FoursetAppDelegate.currentLocation;
    
    //Add maps
    [self addGoogleMap];
    
    //Configure search field
    [self configureSearchUI];
    
    //Add some testing points
    [self addPins:19.4524
           andLng:-99.1358
          andName:@"Drink"
      withAddress:@"New Drink Pub"];
    
    [self addPins:37.784459
           andLng:-122.407127
          andName:@"Coffee"
      withAddress:@"New Coffee Pub"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    mapView.frame = self.mapContainerView.bounds;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UI Setup
- (void)configureSearchUI{
    
//    [AppData setTextFieldBordersRed:self.searchTextField withLeftImage:[[UIImage imageNamed:@"map_view_search_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    [AppData setTextFieldBorders:self.searchTextField
                   withLeftImage:[[UIImage imageNamed:@"map_view_search_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              withLeftImageColor:FS_GREY];
}

#pragma mark - Google Maps
- (void)addGoogleMap{
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    float zoom = 16.;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentUserLocation.coordinate.latitude
                                                            longitude:currentUserLocation.coordinate.longitude
                                                                 zoom:zoom];
    
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, 100, 100) camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    
    //Show location
    if (mapView.myLocation) {
        currentUserLocation = mapView.myLocation;
        camera = [GMSCameraPosition cameraWithLatitude:currentUserLocation.coordinate.latitude
                                             longitude:currentUserLocation.coordinate.longitude
                                                  zoom:zoom];
        
        [mapView animateToCameraPosition:camera];
    }
    
    
    
    //    mapView.mapType = kGMSTypeSatellite;
    [mapView animateToViewingAngle:20];
    
    [self.mapContainerView addSubview:mapView];
}

- (void)addPins:(float)lat andLng:(float)lng andName:(NSString*)strName withAddress:(NSString*)strAddr{
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(lat, lng);
    
    NSLog(@"lat : %f, lng : %f", lat, lng);
    
    marker.icon = [UIImage imageNamed:@"map_pin"];
    marker.title = strName;
    marker.snippet = strAddr;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
}


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
