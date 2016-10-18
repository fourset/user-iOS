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
    float zoom;
    UIImageView *mapPin;
    
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
    zoom = 16.0;
    
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
    mapPin.center = CGPointMake(self.mapContainerView.frame.size.width/2.0, self.mapContainerView.frame.size.height/2.0 - mapPin.frame.size.height / 2.0);

}



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
    mapView.settings.allowScrollGesturesDuringRotateOrZoom = NO;
    
    //Show location
    [self updateSearchField];
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
    
    mapPin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_pin"]];
    [self.mapContainerView addSubview:mapPin];
    
}


- (void) updateSearchField
{
    [_searchTextField setText:@"Getting the location..."];
    //CLGeocoder *ceo = [[CLGeocoder alloc]init];
//    [ceo reverseGeocodeLocation:currentUserLocation
//              completionHandler:^(NSArray *placemarks, NSError *error) {
//                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
//                  NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
//                  [_searchTextField setText:locatedAt];
//              }
//     ];

    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:currentUserLocation.coordinate completionHandler:
     ^(GMSReverseGeocodeResponse *response, NSError *error){
         NSString * address  = response.firstResult.thoroughfare;
         [_searchTextField setText:address];
         
     }];
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

- (IBAction)tapCurrentLocation:(UIButton *)sender {
    [self updateSearchField];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentUserLocation.coordinate.latitude
                                                            longitude:currentUserLocation.coordinate.longitude
                                                                 zoom:zoom];
    currentUserLocation = mapView.myLocation;
    camera = [GMSCameraPosition cameraWithLatitude:currentUserLocation.coordinate.latitude
                                         longitude:currentUserLocation.coordinate.longitude
                                              zoom:zoom];
    
    [mapView animateToCameraPosition:camera];
    
}

#pragma mark - Slide Menu

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

#pragma mark - Map View


- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:position.target completionHandler:
     ^(GMSReverseGeocodeResponse *response, NSError *error){
         NSString * address  = response.firstResult.thoroughfare;
         [_searchTextField setText:address];
     }];
}


@end
