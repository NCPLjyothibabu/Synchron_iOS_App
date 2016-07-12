//
//  LocationViewController.h
//  Synchron
//
//  Created by NCPL Inc on 28/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property(nonatomic,strong)IBOutlet UIButton *locButton;
@property (weak, nonatomic) IBOutlet UIButton *menu;


@end
