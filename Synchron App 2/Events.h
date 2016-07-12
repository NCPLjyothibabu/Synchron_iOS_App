//
//  Events.h
//  Synchron
//
//  Created by NCPL Inc on 28/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "EventFeedback.h"


@interface Events : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property(nonatomic,strong)IBOutlet UIView *view1;
@property(nonatomic,strong)IBOutlet UIView *view2;
@property(nonatomic,strong)IBOutlet UIView *view3;
@property(nonatomic,strong)IBOutlet UIView *view4;
@property(nonatomic,strong)IBOutlet UIButton *btn1;
@property(nonatomic,strong)IBOutlet UIButton *btn2;
@property(nonatomic,strong)IBOutlet UIButton *btn3;
@property(nonatomic,strong)IBOutlet UIButton *btn4;
@property(nonatomic,strong)IBOutlet UIButton *backHome;

@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventAddress;
@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet UILabel *emailID;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property  (weak, nonatomic) IBOutlet NSString *eventID;

@property (weak, nonatomic) IBOutlet UILabel *Attending;
@property (weak, nonatomic) IBOutlet UILabel *Attendency;

@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UILabel *eventTime;
@property (weak, nonatomic) IBOutlet UITextView *eventTopic;

@property (weak, nonatomic) IBOutlet UILabel *eventSpeaker;
@property (weak, nonatomic) IBOutlet UILabel *eventspeakerPosition;
@property (weak, nonatomic) IBOutlet UITextView *eventSpeakerDetails;


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UITableView *speakerTable;


- (IBAction)location:(id)sender;
- (IBAction)agenda:(id)sender;
- (IBAction)speaker:(id)sender;
- (IBAction)attendancy:(id)sender;

- (IBAction)submitFeedback:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *AdvisorScrollView;


@end
