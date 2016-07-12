//
//  Events.m
//  Synchron
//
//  Created by NCPL Inc on 28/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "Events.h"
#import "SWRevealViewController.h"
#import "EventDAO.h"
#import "SpeakerTableCell.h"
#import <Parse/Parse.h>
@interface Events (){

}
- (IBAction)rsvpAlert:(id)sender;
@property CLLocationManager *locationManager;
@property NSString *rsvp;
@property NSData *jsonData;
@property CLLocation *coor;
@property UIActivityIndicatorView *spinner;
@property NSArray *SpeakerName;
@property NSArray *SpeakerDesig;
@property NSArray *SpeakerAbout;

@end

CLLocationManager *locationManager;
MKUserLocation *currentLocation;
NSString *address;
NSString * eventTitle;
NSString * userID;
NSString *userEmail;
NSString *eventId;
EventDAO *eventDao;
NSMutableArray *EventDetailsJson;
@implementation Events
@synthesize sidebarButton,view1,view2,view3,view4,btn1,btn2,btn3,btn4,backHome,mapView,spinner,SpeakerName,SpeakerDesig,SpeakerAbout,speakerTable;
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self UserLognInn];
    userEmail = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserEmail"];
    userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    
//    [self.view addSubview:view1];
//    [self.view addSubview:view2];
//    [self.view addSubview:view3];
//    [self.view addSubview:view4];
    
//    [view3 setHidden:NO];
//    [view1 setHidden:YES];
//    [view2 setHidden:YES];
//    [view4 setHidden: YES];
    
    
    [backHome addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[self mapView] setShowsUserLocation:YES];
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    //[locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    //[locationManager setDesiredAccuracy:CLLocationDistanceMax];
    
    mapView.delegate = self;
    mapView.showsCompass = YES;
    mapView.showsBuildings =YES;
    mapView.showsScale =YES;
    mapView.showsTraffic =YES;
    mapView.scrollEnabled=YES;
    
    // we have to setup the location maanager with permission in later iOS versions
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [[self locationManager] requestWhenInUseAuthorization];
    }
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    
    
    // Getting Details from service
    
    NSString *urlStng = [NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/getevent_details.php?event_id=%@",self.eventID];
    NSURL *url = [NSURL URLWithString:urlStng];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES ];
    
   // NSError *err;
    //[NSURLConnection connectionWithRequest:request delegate:self];
    
   // NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    //NSLog(@" Json before Serialized json: %@",data);
    
    /*
    if (data!= nil) {
        
       NSMutableArray *datajsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSLog(@" Json Serialized json: %@",datajsonArray);
        
        NSString *name = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventName"]];
        address = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventAddress"]];
        NSString *emailID = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"OrgnaiserEmail"]];
        NSString *Phone = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"Phonenumber"]];
        NSString *img = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventLogo"]];
        
         NSString *eventTopic = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventTopic"]];
         NSString *eventDate = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventEndTime"]];
         NSString *eventTime = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventLogo"]];
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:img]];
        
        NSString *eventSpeaker = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventSpeaker"]];
        
        self.eventTitle.text = name;
        self.eventImage.image =[UIImage imageWithData:imageData];
        self.emailID.text = [NSString stringWithFormat:@"Email ID:%@",emailID];
        self.telephone.text =[NSString stringWithFormat:@"Telephone: %@",Phone];
        self.eventAddress.text = address;
        self.eventTopic.text= eventTopic;
        self.eventDate.text = eventDate;
        self.eventTime.text = eventTime;
        self.Attending.text =@" I am Attending";
        self.eventSpeaker.text=eventSpeaker;
        self.eventspeakerPosition.text = @"Advisor";
        self.eventSpeakerDetails.text = eventTopic;
    }
    

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
 */

    // Do any additional setup after loading the view.
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@" Got New location %.4f, %.4f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
//    if (self.altitude ==0) {
//        
//        
//        
//        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 0.5*2003, 0.5*2003);
//        [mapView setRegion:region animated:YES];
//        [locationManager stopUpdatingLocation];
//    }else{
//        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1003, 1003);
//        [mapView setRegion:region animated:YES];
//        [locationManager stopUpdatingLocation];
//    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@" Got New location - MapView Method %.4f, %.4f",userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    currentLocation = [[MKUserLocation alloc]init];
    currentLocation.coordinate = userLocation.coordinate;
    [locationManager stopUpdatingLocation];
    
    //[self makepoint];
}

-(void)makepoint{
    
    NSString *address1 = [NSString stringWithFormat:@"1471,st Street,melbourne,Australia"];
    NSLog(@"GET Addres%@",address1);
    
  
    
//    [geocoder geocodeAddressString:address1 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        
//        CLPlacemark *placemark = [placemarks objectAtIndex:0];
//        
//        NSLog(@"GET placemark%@",placemark);
//        
//        CLLocation *location = placemark.location;
//        
//        NSLog(@"GET location %@",location);
//        
//        CLLocationCoordinate2D coordinate = location.coordinate;
//        
//        MKPointAnnotation *mp = [[MKPointAnnotation alloc]init];
//        mp.title = @" Testing";
//        mp.coordinate = coordinate;
//        
//        
//    }];
    
    MKPointAnnotation *mp = [[MKPointAnnotation alloc]init];
            mp.title = @" Testing";
            mp.coordinate = currentLocation.coordinate;
    


}

//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)home{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)location:(id)sender {
    [view1 setHidden:NO];
    [view2 setHidden:YES];
    [view3 setHidden:YES];
    [view4 setHidden:YES];
    
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_location active.png"] forState:UIControlStateNormal];
    
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Agenda inactive.png"] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Speaker inactive.png"] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Attendance inactive.png"] forState:UIControlStateNormal];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    
    point.title =eventTitle;
    point.subtitle=address;
   // CLLocation *cl = [[CLLocation alloc]initWithLatitude:40.7129838 longitude:-74.00781899999998];
    point.coordinate = CLLocationCoordinate2DMake(self.coor.coordinate.latitude, self.coor.coordinate.longitude);
    [mapView addAnnotation:point];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(point.coordinate, 2003, 2003);
    [self.mapView setRegion:region animated:YES];
    
}

- (IBAction)agenda:(id)sender {
    [view3 setHidden:NO];
    [view1 setHidden:YES];
    [view2 setHidden:YES];
    [view4 setHidden:YES];
    
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_location inactive.png"] forState:UIControlStateNormal];
    
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Agenda active.png"] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Speaker inactive.png"] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Attendance inactive.png"] forState:UIControlStateNormal];
    
}

- (IBAction)speaker:(id)sender {
    [view2 setHidden:NO];
    [view3 setHidden:YES];
    [view1 setHidden:YES];
    [view4 setHidden:YES];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_location inactive.png"] forState:UIControlStateNormal];
    
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Agenda inactive.png"] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Speaker active.png"] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Attendance inactive.png"] forState:UIControlStateNormal];
}

- (IBAction)attendancy:(id)sender {
    [view4 setHidden:NO];
    [view2 setHidden:YES];
    [view3 setHidden:YES];
    [view1 setHidden:YES];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_location inactive.png"] forState:UIControlStateNormal];
    
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Agenda inactive.png"] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Speaker inactive.png"] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"005 Synchron_Eventdetails_tab_Attendance active.png"] forState:UIControlStateNormal];
}

- (IBAction)submitFeedback:(id)sender {
  
    [self performSegueWithIdentifier:@"eventFeedback" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"eventFeedback"]) {
        EventFeedback *ev =[segue destinationViewController];
        [ev setEventDetails:EventDetailsJson];
    }
}
- (IBAction)rsvpAlert:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"  RSVP  " message:@" Are you willing to join the Meeting ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Yes = [UIAlertAction actionWithTitle:@"Attending" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.rsvp = @"Attending";
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/rsvp_attendance.php?EventId=%@&UserEmailId=%@&Status=%@",eventId,userEmail,self.rsvp]];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:kNilOptions error:nil];
        
        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (json!=nil) {
            
                self.Attending.text = @"I am Attending";
            
            
        }
       
    }];
    
    UIAlertAction *No = [UIAlertAction actionWithTitle:@"Not attending" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.rsvp = @"NotAttending";
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/rsvp_attendance.php?EventId=%@&UserEmailId=%@&Status=%@",eventId,userEmail,self.rsvp]];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:kNilOptions error:nil];
        
        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (json!=nil) {
            
            self.Attending.text = @"I am not Attending";
            
            
        }
    }];
    
    UIAlertAction *Maybe = [UIAlertAction actionWithTitle:@"Tentative" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.rsvp = @"Tentative";
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/rsvp_attendance.php?EventId=%@&UserEmailId=%@&Status=%@",eventId,userEmail,self.rsvp]];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:kNilOptions error:nil];
        
        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (json!=nil) {
            
            self.Attending.text = @"Tentative";
            
            
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.rsvp = @"";
        self.Attending.text = @"";
    }];

    [alertController addAction:Yes];
    [alertController addAction:No];
    [alertController addAction:Maybe];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)sendAttendance{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/rsvp_attendance.php?EventId=%@&UserEmailId=%@&Status=%@",eventId,userEmail,self.rsvp]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:kNilOptions error:nil];
    
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (json!=nil) {
        if ([self.rsvp isEqualToString:@"Attending"]) {
            self.Attending.text = @"I am Attending";
        }else if ([self.rsvp isEqualToString:@"NotAttending"]){
            self.Attending.text = @"I am not attending";
        }else{
            self.Attending.text = @"Tentative";
        }
        
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@" In Did receive Response");
    self.jsonData = [[NSData alloc]init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
     NSLog(@" In Did receive Data");
    self.jsonData = [NSData dataWithData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
     NSLog(@" In Did Finish Loading");
    NSMutableArray *datajsonArray = [NSJSONSerialization JSONObjectWithData:self.jsonData options:kNilOptions error:nil];
    EventDetailsJson = [NSMutableArray arrayWithArray:datajsonArray];
    NSLog(@" Json Serialized json: %@",datajsonArray);
    
    eventTitle = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventName"]];
    address = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventAddress"]];
    NSString *emailID = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"OrgnaiserEmail"]];
    NSString *Phone = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"Phonenumber"]];
    NSString *img = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventLogo"]];
    
    NSString *eventTopic = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventTopic"]];
    NSString *eventDate = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventStartdate"]];
    NSString *eventSTime = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventStartTime"]];
    NSString *eventETime = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventEndTime"]];
    NSString *eventState = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventCity"]];
    NSString *eventCountry = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventCountry"]];
    NSString *EventAttendance = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventAttendance"]];
    eventId = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"EventId"]];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:img]];
    
    NSString *eventSpeaker = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"SpeakerName"]];
    NSString *eventSpeakerDesg = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"SpeakerDesg"]];
    NSString *eventAboutSpkr = [NSString stringWithFormat:@"%@",[datajsonArray[0] valueForKey:@"AboutSpeaker"]];
    SpeakerName = [eventSpeaker componentsSeparatedByString:@"sari123sari123"];
    SpeakerDesig = [eventSpeakerDesg componentsSeparatedByString:@"sari123sari123"];
    SpeakerAbout = [eventAboutSpkr componentsSeparatedByString:@"sari123sari123"];
    [self.speakerTable reloadData];
//    if (SpeakerName.count==1) {
//        self.eventSpeaker.text=eventSpeaker;
//        self.eventspeakerPosition.text = eventSpeakerDesg;
//        self.eventSpeakerDetails.text = eventAboutSpkr;
//    }else if (SpeakerName.count>1){
//        self.AdvisorScrollView.contentSize = CGSizeMake(self.view2.bounds.size.width, (self.view2.bounds.size.height/2)*SpeakerName.count);
//        self.eventSpeaker.hidden =YES;
//        self.eventspeakerPosition.hidden=YES;
//        self.eventSpeakerDetails.hidden =YES;
//        
//        NSMutableArray * Lables =[[NSMutableArray alloc]init];
//        for (int i=0; i<SpeakerName.count; i++) {
//            UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(50, 50*i, 400, 20)];
//            UILabel *degig = [[UILabel alloc]initWithFrame:CGRectMake(50, 90*i, 400, 20)];
//            UITextView *about= [[UITextView alloc]initWithFrame:CGRectMake(20, 120*i, 400, 50)];
//    
//            
//            [self.view2 addSubview:name];
//            [self.view2 addSubview:degig];
//            [self.view2 addSubview:about];
//            [Lables addObject:name];
//            [Lables addObject:degig];
//            [Lables addObject:about];
//        }
//       
//        
//    }else{
//        NSLog(@" No speaker are available");
//    }
    
    
    NSLog(@" Speaker Names :%@ : Designation : %@ : about : %@ ",SpeakerName,SpeakerDesig,SpeakerAbout);
    
    
    self.eventTitle.text = eventTitle;
    self.eventImage.image =[UIImage imageWithData:imageData];
    self.emailID.text = [NSString stringWithFormat:@"Email ID:%@",emailID];
    self.telephone.text =[NSString stringWithFormat:@"Telephone: %@",Phone];
    self.eventAddress.text = address;
    self.eventTopic.text= eventTopic;
    self.eventDate.text = eventDate;
    self.eventTime.text = [NSString stringWithFormat:@"Between %@ to %@",eventSTime,eventETime];
    self.Attending.text =@" ";
    
    self.Attendency.text=EventAttendance;
    
    eventDao = [[EventDAO alloc]init];
    [eventDao setEventTitle:eventTitle];
    [eventDao setEventAddress:address];
    [eventDao setEventImage:img];
    [eventDao setEventId:eventId];
    
    NSLog(@" In Event Class: %@",eventDao.EventTitle);
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSString * address= [NSString stringWithFormat:@"%@,%@",eventState,eventCountry];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Process the placemark.
            NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
            NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
            NSLog(@" New location is %@,%@",latDest1,lngDest1);
            self.coor = [[CLLocation alloc]initWithLatitude:aPlacemark.location.coordinate.latitude longitude:aPlacemark.location.coordinate.longitude];
            //self.coor = aPlacemark.location;
            //self.coor = (__bridge CLLocationCoordinate2D *)([aPlacemark location]);
            
        }
        
    }];
    [spinner stopAnimating];

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@" In Did Fail with Error");
}

-(void)AddPoints:(NSString*)Title SubTitle:(NSString*)subTitle LocationCoord:(CLLocationCoordinate2D*)location{
    MKPointAnnotation *pin = [[MKPointAnnotation alloc]init];
    pin.coordinate =*(location);
    pin.title =Title;
    pin.subtitle = subTitle;
    //[mapView removeAnnotation:mapView.annotations];
    [mapView addAnnotation:pin];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return SpeakerName.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //static NSString *Cell =@"cell";
    
    SpeakerTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[SpeakerTableCell alloc]init];
    }
    
    
    //Cell.textLabel.text = [SpeakerName objectAtIndex:indexPath.row];
    cell.speakerName.text = [SpeakerName objectAtIndex:indexPath.row];
    cell.speakerDesig.text = [SpeakerDesig objectAtIndex:indexPath.row];
    cell.speakerAbout.text = [SpeakerAbout objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)UserLognInn {
    NSString*name =  [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    NSString * email=  [[NSUserDefaults standardUserDefaults]objectForKey:@"UserEmail"];
    NSData *imagedata = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserImage"];
    PFFile *imageFile = [PFFile fileWithName:@"userImage.png" data:imagedata];
    PFUser *user = [PFUser user];
    user.username = email;
    user.password = @"@1234";
    user.email = email;
    user [@"UserImage"] = imageFile;
    
    // other fields can be set just like with PFObject
    //user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            NSLog(@"Sign UP Success %@",[PFUser currentUser]);
        } else {   NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            [PFUser logInWithUsernameInBackground:email password:@"@1234"
                                            block:^(PFUser *user, NSError *error) {
                                                if (user) {
                                                    // Do stuff after successful login.
                                                    NSLog(@"User Loginn is :%@",user);
                                                    PFFile *Image = user[@"UserImage"];
                                                    NSLog(@"image url %@ ",Image.url);
                                                } else {
                                                    // The login failed. Check error to see why.
                                                }
                                            }];
            
        }
    }];
    
}
@end
