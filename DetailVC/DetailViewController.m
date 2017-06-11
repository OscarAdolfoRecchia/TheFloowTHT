//
//  DetailViewController.m
//  OAR_THT
//
//  Created by Oscar Adolfo Recchia on 08/06/2017.
//  Copyright © 2017 Oscar Adolfo Recchia. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController



NSMutableArray  *allPoints;


-(void)viewWillAppear:(BOOL)animated
{
    
     _myDetMKMap.showsUserLocation = NO;
   // self.myDetMKMap.userTrackingMode = MKUserTrackingModeFollow;

    
    allPoints  = [[NSMutableArray  alloc]  init];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    NSString  *arrayName  =  [NSString   stringWithFormat:@"%@_array",_myTitle.text];
    
    
    NSMutableDictionary  *mymd = [defaults objectForKey:arrayName];
    
   allPoints = [mymd mutableArrayValueForKey:@"pinpoint"];
    
    CLLocationCoordinate2D pinCoordinates;
    
    NSMutableDictionary  *coord = [allPoints   objectAtIndex:0];
        NSArray *alon = [coord valueForKey:@"longitude"];
    
    for  (int i =0; i< [alon  count]; i++) {
        
   

       
        
        NSArray *alon = [coord valueForKey:@"longitude"];
        NSNumber  *lon  =  [alon  objectAtIndex:i];
        float flon = [lon floatValue];
        NSArray *alat = [coord valueForKey:@"latitude"];
        NSNumber  *lat  =  [alat  objectAtIndex:i];

        float flat = [lat floatValue];
        pinCoordinates.latitude  = flat;
        pinCoordinates.longitude  = flon;
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:pinCoordinates];
        // [annotation setTitle:@"Start"]; //You can set the subtitle too
        [self.myDetMKMap addAnnotation:annotation];
    
}
    
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in _myDetMKMap.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [_myDetMKMap setVisibleMapRect:zoomRect animated:YES];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [_myDetMKMap setMapType:MKMapTypeStandard];
    [_myDetMKMap removeAnnotations:_myDetMKMap.annotations];
    _myDetMKMap.showsUserLocation = NO;
    [_myDetMKMap setUserTrackingMode:MKUserTrackingModeFollow animated:NO];

    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (IBAction)detBack:(id)sender {
    
        [self  dismissViewControllerAnimated:YES completion:nil];
}
@end
