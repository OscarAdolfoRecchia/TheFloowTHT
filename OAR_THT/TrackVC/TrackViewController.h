//
//  TrackViewController.h
//  OAR_THT
//
//  Created by Oscar Adolfo Recchia on 08/06/2017.
//  Copyright © 2017 Oscar Adolfo Recchia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@class HomeViewController;


@interface TrackViewController : UIViewController<CLLocationManagerDelegate,
MKMapViewDelegate>

- (IBAction)PreviousView:(id)sender;

@property (strong, nonatomic) IBOutlet MKMapView *myMap;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property  float  distance;


@property (strong, nonatomic)  NSMutableArray *mylocations;

@property (strong, nonatomic)  NSMutableArray  *locationsArray;

- (IBAction)Start:(id)sender;
- (IBAction)Stop:(id)sender;

@property (strong, nonatomic)  HomeViewController  *parentView;

- (id) myTrackInit;

@end
