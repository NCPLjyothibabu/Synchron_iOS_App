//
//  MainViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventTableViewCell.h"
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,CLLocationManagerDelegate>
{
    NSArray *Title;
    NSArray *Description;
    NSArray *Image;
}

@property (strong, atomic) IBOutlet UIBarButtonItem *sidebarButton;
@property(strong,nonatomic)IBOutlet UIButton*   main;

@property (strong, atomic) IBOutlet UITableView *tableView;

@property (strong, atomic) IBOutlet UIActivityIndicatorView *spinner;

@property(strong, atomic) NSMutableArray * datajsonArray;
@property (strong, atomic) NSString *EventId;
@property (strong, atomic) NSData *jsonData;
@end
