//
//  TrackViewController.m
//  OAR_THT
//
//  Created by Oscar Adolfo Recchia on 08/06/2017.
//  Copyright © 2017 Oscar Adolfo Recchia. All rights reserved.
//

#import "TrackViewController.h"

@interface TrackViewController ()

@end

@implementation TrackViewController

NSDate  *startDate;
NSDate  *endDate;
long n_paths;

NSUserDefaults *defaults;
NSMutableDictionary  *coordDict;
NSMutableDictionary  *dictionary;
NSMutableArray   *array;
NSMutableArray *arrayObj;


-(id)myTrackInit {

    
     [super initWithNibName:@"TrackViewController" bundle:nil];
    
        if ( self ) {

defaults = [NSUserDefaults standardUserDefaults];
        startDate  = [[NSDate  alloc]  init];
        endDate  = [[NSDate  alloc]  init];
        
        _locationsArray  =  [[NSMutableArray alloc]  init];
        _mylocations  =  [[NSMutableArray alloc]  init];
        
        [_myMap setMapType:MKMapTypeStandard];
        
        self.myMap.userTrackingMode = MKUserTrackingModeFollow;
            coordDict  = [[NSMutableDictionary   alloc] init];
            array = [[NSMutableArray  alloc] init];

    }
    return self;
}


- (void)viewDidLoad {
    
  
    
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    [self enableLocationServices];
    [self setupLocationManager];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)PreviousView:(id)sender {
    

    
   [self  dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)Start:(id)sender {
        [self startLocationManager];
    [_myMap removeAnnotations:_myMap.annotations];
    coordDict  = [[NSMutableDictionary   alloc] init];
    array = [[NSMutableArray  alloc] init];
arrayObj  = [[NSMutableArray  alloc] init];
    
    
    
   
}

- (IBAction)Stop:(id)sender {
    


    
    [_locationManager stopUpdatingLocation];
      _locationManager  = nil;
   NSLog(@"Location Services disabled.");
    // detect timestamp
    //  save all data on userdefaults
    
    n_paths = [defaults integerForKey:@"n_paths"];
    
    n_paths++;
    
    [defaults setInteger:n_paths forKey:@"n_paths"];
    [defaults synchronize];
    
    NSString  *journeyName  =  [NSString   stringWithFormat:@"Journey_n_%li",n_paths];
    
    
    

    
   NSInteger  count = [self.mylocations count];
    
    CLLocationCoordinate2D coordinate;
    CLLocation  *clcoordinates;
    
    
        clcoordinates  = [_mylocations   objectAtIndex:0];
        
        NSLog(@"clcoordinates = %@", clcoordinates);
        
        NSDate  *jDate  = clcoordinates.timestamp;
        
        coordinate.latitude  =  clcoordinates.coordinate.latitude;
        
        coordinate.longitude  =  clcoordinates.coordinate.longitude;

    
        
 
        

    
    
     //   [defaults setObject:totalDistance forKey:@"totalDistance"];
    
    [defaults  setObject:jDate forKey:journeyName];
    
    NSString  *endName  =  [NSString   stringWithFormat:@"Journey_n_%li_end",n_paths];

    [defaults  setObject:endDate forKey:endName];
    
    
    
    NSString  *arrayName  =  [NSString   stringWithFormat:@"Journey_n_%li_array",n_paths];

 
    NSMutableDictionary  *thisDict  =  [[NSMutableDictionary  alloc]  init];
    
    
    [ thisDict   setObject:array forKey:@"pinpoint"];
    
    
    
    [arrayObj   addObject:thisDict];
    
    [defaults setObject:arrayObj forKey:arrayName];
  
    
    
        
        [defaults synchronize];
    _myMap.showsUserLocation = NO;
  
    
}


- (void) startLocationManager{
    
    if (!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    

        [_locationManager requestWhenInUseAuthorization];
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }

    
    
    [_locationManager startUpdatingLocation];
    
    
    
}


- (BOOL) enableLocationServices {
    _myMap.showsUserLocation = YES;

    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.distanceFilter = 30;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
          [self.myMap setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        return YES;
    } else {
        return NO;
    }
}

- (void) setupLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Will call locationManager:didChangeAuthorizationStatus: delegate method
    [CLLocationManager authorizationStatus];
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    NSString *message = @"You must enable Location Services for this app in order to use it.";
    NSString *button = @"Ok";
    NSString *title;
    
    if (status == kCLAuthorizationStatusDenied) {
        title = @"Location Services Disabled";
        [[[UIAlertView alloc] initWithTitle:title
                                    message:message
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:button, nil] show];
    } else if(status == kCLAuthorizationStatusRestricted) {
        title = @"Location Services Restricted";
        [[[UIAlertView alloc] initWithTitle:title
                                    message:message
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:button, nil] show];
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // Note: kCLAuthorizationStatusAuthorizedWhenInUse depends on the request...Authorization
        // (Always or WhenInUse)
        if ([self enableLocationServices]) {
            NSLog(@"Location Services enabled.");
        } else {
            NSLog(@"Couldn't enable Location Services. Please enable them in Settings > Privacy > Location Services.");
        }
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"Error : Authorization status not determined.");
        [self.locationManager requestWhenInUseAuthorization];
        
        
        
    }
    
    
}

- (void)locationManager:(CLLocationManager *)manager
      didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
 
    dictionary = [[NSMutableDictionary  alloc] init];

    
    CLLocation *newLocation = [locations  lastObject];
    
        if (newLocation.horizontalAccuracy < 20) {
            
            // update distance
            if (self.mylocations.count > 0) {
                CLLocationCoordinate2D pinCoordinates;
                pinCoordinates.longitude = newLocation.coordinate.longitude;
                pinCoordinates.latitude = newLocation.coordinate.latitude;
                
                NSNumber  *fla  = [NSNumber         numberWithFloat: pinCoordinates.latitude];
                
                NSNumber  *flo  = [NSNumber         numberWithFloat: pinCoordinates.longitude];

                [dictionary   setValue:fla forKey:@"latitude"];
                [dictionary   setValue:flo forKey:@"longitude"];
                
                
                
                
                
                [array    addObject:dictionary];

                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                [annotation setCoordinate:pinCoordinates];
                // [annotation setTitle:@"Start"]; //You can set the subtitle too
                [self.myMap addAnnotation:annotation];

                [self.mylocations addObject:locations];
                
                endDate  =  newLocation.timestamp;


            //    self.distance += [newLocation distanceFromLocation:_mylocations.lastObject];
            }  else
                if ( self.mylocations.count ==0)
                {
                    
                    CLLocationCoordinate2D pinCoordinates;
                    pinCoordinates.longitude = newLocation.coordinate.longitude;
                    pinCoordinates.latitude = newLocation.coordinate.latitude;
                    
                    NSNumber  *fla  = [NSNumber         numberWithFloat: pinCoordinates.latitude];
                    
                    NSNumber  *flo  = [NSNumber         numberWithFloat: pinCoordinates.longitude];
                    
                    [dictionary   setValue:fla forKey:@"latitude"];
                    [dictionary   setValue:flo forKey:@"longitude"];
                    
                    
                    
                                     [array    addObject:dictionary];
                    
                    
                    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                    [annotation setCoordinate:pinCoordinates];
                   // [annotation setTitle:@"Start"]; //You can set the subtitle too
                    [self.myMap addAnnotation:annotation];
                    
   
                    
                         [self.mylocations addObject:newLocation];
                    
                    NSLog(@"Prima coordinata:  %@ ", locations);
                    
                    startDate  =  newLocation.timestamp;
                    
                    
                    
                    
                }
                
            
        
        
                   }
    }
    






@end
