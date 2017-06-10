//
//  HomeViewController.m
//  OAR_THT
//
//  Created by Oscar Adolfo Recchia on 08/06/2017.
//  Copyright © 2017 Oscar Adolfo Recchia. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)ActSel:(id)sender {
    
 
    TrackViewController * trackVc = [[TrackViewController alloc] initWithNibName:@"TrackViewController" bundle:nil];

    
    
    [self   presentViewController:trackVc animated:YES completion:nil];
}

- (IBAction)JourneyListSel:(id)sender {
    
  JListViewController *  jListVc = [[JListViewController alloc] initWithNibName:@"JListViewController" bundle:nil];
    
    
    [self   presentViewController:jListVc animated:YES completion:nil];
}
@end
