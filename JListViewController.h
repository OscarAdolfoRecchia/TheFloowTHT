//
//  JListViewController.h
//  OAR_THT
//
//  Created by Oscar Adolfo Recchia on 08/06/2017.
//  Copyright © 2017 Oscar Adolfo Recchia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface JListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)Back:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *myTV;

@property (strong, nonatomic)  DetailViewController  *dvc;

@end
