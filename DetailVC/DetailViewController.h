//
//  DetailViewController.h
//  OAR_THT
//
//  Created by Oscar Adolfo Recchia on 08/06/2017.
//  Copyright © 2017 Oscar Adolfo Recchia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *dateandtime;

@property (strong, nonatomic) IBOutlet UILabel *myTitle;

- (IBAction)detBack:(id)sender;

@end
