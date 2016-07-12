//
//  MainViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "EventTableViewCell.h"
#import "LoginPage.h"
#import "Events.h"
#import "EventDAO.h"
#import <Parse/Parse.h>
//#import "AFNetworking.h"

//#import "JSON.h"

@interface MainViewController ()  //<NSURLConnectionDelegate>
@property(atomic,strong)NSArray *name;
@property dispatch_queue_t myQueue ;
@property (strong, atomic) NSMutableArray *events;
@end



@implementation MainViewController
@synthesize name,main,datajsonArray,EventId,jsonData, myQueue,events;
- (void)viewDidLoad {
    [super viewDidLoad];
    
   CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    //[locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
 

    //self.title = @"Upcoming Events";
    self.navigationController.navigationBarHidden  = YES;
   // [main addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
//        [self.sidebarButton setTarget: self.revealViewController];
//        [self.sidebarButton setAction: @selector( revealToggle: )];
        [main addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
   // name=[[NSArray alloc]initWithObjects:@"NCPL",@"Synchron",@"Wire Frames", nil];
    
  
   // NSError *err;
   // NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    //NSLog(@" Json before Serialized json: %@",data);
    
//    if (data!= nil) {
//    
//    datajsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        NSString *name = [NSString stringWithFormat:@"%@",[datajsonArray valueForKey:@"Contact_Person"]];
//   // NSLog(@" Json Serialized json: %@",datajsonArray);
//        
//    }
    
   myQueue = dispatch_queue_create("myQueue", NULL);

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]) {
        
        LoginPage *login = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        [self presentViewController:login animated:YES completion:nil];
    }else{
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
        NSString *str = [NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/allevents.php?userid=%@",userId];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/allevents.php?userid=%@",userId]];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        NSLog(@"Requesting Url is : %@",url);
        [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
        
//        str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:str]];
//        [request setUseKeychainPersistence:YES];
//        
//        
//        [request setRequestMethod:@"GET"];
//        
//        [request setDelegate:self];
//        [request setDidFinishSelector:@selector(PostIssueRequestFinished:)];
//        [request setDidFailSelector:@selector(PostIssueRequestFailed:)];
//        [request startAsynchronous];
        if(events.count>0){
            
        }else{
            
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return events.count;
    
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
/*
- (void)tableView:(UITableView *)tableView didDisplayCell:(EventTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //EventTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    EventDAO *a = [events objectAtIndex:indexPath.row];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:a.EventImage]];
    
    cell.eventTitle.text=a.EventTitle;
    cell.eventAdd.text = a.EventAddress;
    cell.attendancy.text = a.EventAttending;
    cell.image.image = [UIImage imageWithData:imageData];
    
    
    // execute a task on that queue asynchronously
    dispatch_async(myQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:a.EventImage]];
        //UI updates should remain on the main thread
        //UIImage *offersImage = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *offersImage = [UIImage imageWithData:data];
            
            cell.image.image = offersImage;
        });
    });
    
    if ([a.AttendingStatus isEqualToString:@"NotAttending"]) {
        cell.attendingStatusImg.image = [UIImage imageNamed:@"003 Synchron_UEvents_notattending_icon.png"];
        
    }else if([a.AttendingStatus isEqualToString:@"Attending"]){
        cell.attendingStatusImg.image = [UIImage imageNamed:@"003 Synchron_UEvents_attending_icon.png"];
        
    }else if ([a.AttendingStatus isEqualToString:@"Tentative"]){
        cell.attendingStatusImg.image = [UIImage imageNamed:@"003 Synchron_UEvents_tentitive_icon.png"];
        
    }else{
        cell.attendingStatusImg.image = [UIImage imageNamed:@""];
    }
}*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EventTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil) {
        cell=[[EventTableViewCell alloc]init];
    }
    
//    EventId = [NSString stringWithFormat:@"%@",[datajsonArray[indexPath.row] valueForKey:@"EventId"]];
//    NSString *title = [NSString stringWithFormat:@"%@",[datajsonArray[indexPath.row] valueForKey:@"EventName"]];
//    NSString *address = [NSString stringWithFormat:@"%@",[datajsonArray[indexPath.row] valueForKey:@"EventAddress"]];
//    NSString *attendancy = [NSString stringWithFormat:@"%@",[datajsonArray[indexPath.row] valueForKey:@"EventAttendance"]];
//    NSString *image = [NSString stringWithFormat:@"%@",[datajsonArray[indexPath.row] valueForKey:@"EventImage"]];
    
    EventDAO *a = [events objectAtIndex:indexPath.row];
    
    //NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:a.EventImage]];
    
    cell.eventTitle.text=a.EventTitle;
    cell.eventAdd.text = a.EventAddress;
    cell.attendancy.text = a.EventAttending;
    cell.date_time.text = a.Date_Time;
    //cell.image.image = [UIImage imageWithData:imageData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        NSData *data0 = [NSData dataWithContentsOfURL:[NSURL URLWithString:a.EventImage]];
        UIImage *image = [UIImage imageWithData:data0];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            //UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
            cell.image.image = image;
        });
    });
    if ([a.AttendingStatus isEqualToString:@"NotAttending"]) {
        cell.attendingStatusImg.image = [UIImage imageNamed:@"003 Synchron_UEvents_notattending_icon.png"];
        
    }else if([a.AttendingStatus isEqualToString:@"Attending"]){
        cell.attendingStatusImg.image = [UIImage imageNamed:@"003 Synchron_UEvents_attending_icon.png"];
        
    }else if ([a.AttendingStatus isEqualToString:@"Tentative"]){
        cell.attendingStatusImg.image = [UIImage imageNamed:@"003 Synchron_UEvents_tentitive_icon.png"];
        
    }else{
        cell.attendingStatusImg.image = [UIImage imageNamed:@""];
    }
    
    //cell.CellTitle.text = Title[row];
  //  cell.CellDescription.text = Description[row];
   // cell.CellImageview.image = [UIImage imageNamed:Image[row]];
   // cell.imageView.image=[UIImage imageNamed:@"10.jpg"];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Events *event = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetails"];
     EventId = [NSString stringWithFormat:@"%@",[datajsonArray[indexPath.row] valueForKey:@"EventId"]];
    [event setEventID:EventId];
    [self.navigationController pushViewController:event animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    jsonData =[[NSData alloc]init];
    datajsonArray = [[NSMutableArray alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    jsonData = [NSData dataWithData:data];
}
//-(void)PostIssueRequestFinished:(ASIHTTPRequest*)request
//{
//   // NSString *response  =[request responseData];
////    if ([response isEqualToString:@"success"]) {
////        [self showAlert:@"SuccessFully Posted."];
////    }
//    NSLog(@"Result array: %@", [request responseData]);
//    
//    
//}
-(void)displaydata{
    
//    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/allevents.php?userid=%@",userId]];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
   
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        
//        datajsonArray = responseObject;
//        NSLog(@"Response form AF Net : %@",datajsonArray);
//        
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Network Error"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
    
   // [[NSURLConnection alloc]initWithRequest:request delegate:self];
    datajsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSLog(@" This is parsed Data: %@",datajsonArray[0]);
    
    events = [[NSMutableArray alloc]initWithCapacity:datajsonArray.count];
    
    for (int i=0; i<datajsonArray.count; i++) {
        
        EventId = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventId"]];
        NSString *title = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventName"]];
        NSString *address = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventAddress"]];
        NSString *attendancy = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventAttendance"]];
        NSString *image = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventImage"]];
        NSString *attStatus = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"AttendanceStatus"]];
       
        NSString *Date = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventStartdate"]];
        NSString *Time = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventStartTime"]];
        NSString *data_time = [NSString stringWithFormat:@"%@,%@",Date,Time];
        
       // EventDAO *eDao = [[EventDAO alloc]initWithEventTitle:title Address:address EvImage:image EventID:EventId EventAtt:attendancy AttengingStatus:attStatus];
        NSLog(@"Adding into Array");
       // [events addObject:eDao];
        //[self performSelectorOnMainThread:@selector(tableView) withObject:nil waitUntilDone:YES];
    }
    
    [self.tableView reloadData];
    [self.spinner stopAnimating];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    datajsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSLog(@" This is parsed Data: %@",datajsonArray[0]);
    if (datajsonArray == NULL) {
        UIAlertView *At =[[UIAlertView alloc]initWithTitle:@"Synchron" message:@"Please check your network connection"  delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [At show];
    }
    events = [[NSMutableArray alloc]initWithCapacity:datajsonArray.count];
    
    for (int i=0; i<datajsonArray.count; i++) {
        
        EventId = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventId"]];
        NSString *title = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventName"]];
        NSString *address = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventAddress"]];
        NSString *attendancy = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventAttendance"]];
        NSString *image = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventImage"]];
        NSString *attStatus = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"AttendanceStatus"]];
        
        NSString *Date = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventStartdate"]];
        NSString *Time = [NSString stringWithFormat:@"%@",[datajsonArray[i] valueForKey:@"EventStartTime"]];
        NSString *data_time = [NSString stringWithFormat:@"%@,%@",Date,Time];
        
        EventDAO *eDao = [[EventDAO alloc]initWithEventTitle:title Address:address EvImage:image EventID:EventId EventAtt:attendancy AttengingStatus:attStatus Date_Time:data_time];
        NSLog(@"Adding into Array" );
        [events addObject:eDao];
        //[self performSelectorOnMainThread:@selector(tableView) withObject:nil waitUntilDone:YES];
    }
    
    [self.tableView reloadData];
    [self.spinner stopAnimating];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@" Updated locations are %@",locations);
}



@end
