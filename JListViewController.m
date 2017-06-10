//
//  JListViewController.m
//  OAR_THT
//
//  Created by Oscar Adolfo Recchia on 08/06/2017.
//  Copyright © 2017 Oscar Adolfo Recchia. All rights reserved.
//

#import "JListViewController.h"

@interface JListViewController ()

@end

@implementation JListViewController


static NSString *cellIdentifier = @"Cell";
    


- (void)viewDidLoad {
    


    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _myTV.delegate  = self;
    _myTV.dataSource  = self;
    
    
    [_myTV  reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    NSUserDefaults *defaults;
defaults = [NSUserDefaults standardUserDefaults];
 long n_paths = [defaults integerForKey:@"n_paths"];

    
    
    return    n_paths;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    NSString  * currJourney = [NSString  stringWithFormat:@"Journey_n_%li",(indexPath.row)+1];
    
    
    cell.textLabel.text = currJourney;
  //  cell.detailTextLabel.text = [self.tableDetailData objectAtIndex:indexPath.row];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    NSString  * currJourney = [NSString  stringWithFormat:@"Journey_n_%li",(indexPath.row)+1];
    
    NSDate  *myDate =[defaults objectForKey:currJourney];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"];
    
    NSString *stringFromDate = [formatter stringFromDate:myDate];
    
  
    
    
    [self   presentViewController:_dvc animated:YES completion:nil];

    _dvc.dateandtime.text  = [NSString  stringWithString:stringFromDate];
    _dvc.myTitle.text  = [NSString  stringWithString:currJourney];
    

    
}


    /*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Back:(id)sender {
    
    [self  dismissViewControllerAnimated:YES completion:nil];

    
}
@end
