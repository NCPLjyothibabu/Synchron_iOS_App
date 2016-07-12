//
//  LocationViewController.m
//  Synchron
//
//  Created by NCPL Inc on 28/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "LocationViewController.h"
#import <MapKit/MapKit.h>

#import "SWRevealViewController.h"
@interface LocationViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocationManager *locationManager;
@property CLLocation *coor;
@end

@implementation LocationViewController
@synthesize mapView,locationManager;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self.menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self MapWithLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)MapWithLocation{
    [[self mapView] setShowsUserLocation:YES];
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    //[locationManager requestWhenInUseAuthorization];
    
    //[locationManager setDesiredAccuracy:CLLocationDistanceMax];
    
    mapView.delegate = self;
    mapView.showsCompass = YES;
    mapView.showsBuildings =YES;
    mapView.showsScale =YES;
    mapView.showsTraffic =YES;
    mapView.scrollEnabled=YES;
    
    // we have to setup the location maanager with permission in later iOS versions
    if ([[self locationManager] respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [[self locationManager] requestAlwaysAuthorization];
    }
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    [locationManager startUpdatingLocation];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@" User locations %@ Current Loca :",userLocation);
    [self SynchronAddress];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@" User locations %@ & Current Loca : %@",locations,locations[0]);
  
    [locationManager stopUpdatingLocation];
}

-(void)SynchronAddress{
    
   
        MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
        
        point.title =@"Synchron Office";
        point.subtitle=@"65 Palmerston Cres, South Melbourne VIC 3205, Australia";
        CLLocation *cl = [[CLLocation alloc]initWithLatitude:-37.834897 longitude:144.969298];
        point.coordinate = CLLocationCoordinate2DMake(cl.coordinate.latitude, cl.coordinate.longitude);
        [mapView addAnnotation:point];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(point.coordinate, 2003, 2003);
        [self.mapView setRegion:region animated:YES];
   
}

@end
