//
//  EventFeedback.m
//  Synchron
//
//  Created by NCPL Inc on 29/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "EventFeedback.h"
#import "SWRevealViewController.h"
@interface EventFeedback ()
@property NSData *jsonData;
@end

@implementation EventFeedback
@synthesize sidebarButton,EventDetails,userID,eventId;
- (void)viewDidLoad {
    [super viewDidLoad];
    
     CGSize iOSScreenSize=[[UIScreen mainScreen]bounds].size;
    if (iOSScreenSize.height ==736) {
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    }else{
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+(self.view.bounds.size.height/2));
    }
    
    
//    SWRevealViewController *revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
//        [self.sidebarButton setTarget: self.revealViewController];
//        [self.sidebarButton setAction: @selector( revealToggle: )];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
    // Do any additional setup after loading the view.
    
    [self performSelectorInBackground:@selector(fetchdata) withObject:nil];
  
}

- (void)didReceiveMemoryWarning
{
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


-(void)fetchdata
{
    NSString *eventTitle = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventName"]];
    NSString* address = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventAddress"]];
    userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    eventId = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventId"]];
    
    NSString *img = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventLogo"]];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:img]];
    self.eventTitle.text = eventTitle;
    self.eventAddress.text =address;
    self.eventImage.image = [UIImage imageWithData:imageData];
    NSString *urlStng = [NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/get_eventfeedback.php?event_id=%@&user_id=%@",eventId,userID];
    NSURL *url = [NSURL URLWithString:urlStng];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES ];
}

- (IBAction)speaker:(id)sender {
    [self performSegueWithIdentifier:@"SpeakerFeedback" sender:self];
}

- (IBAction)content:(id)sender
{
    [self performSegueWithIdentifier:@"ContentFeedback" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier ] isEqualToString:@"SpeakerFeedback"]) {
        SpeakersFeedback *sf = [segue destinationViewController];
        //sf.EventDetails= self.eventDetails;
        [sf setEventDetails:EventDetails];
    }
    if ([[segue identifier ] isEqualToString:@"ContentFeedback"]) {
        ContentFeedback *sf = [segue destinationViewController];
        //sf.EventDetails= self.eventDetails;
        [sf setEventDetails:EventDetails];
    }
}

- (IBAction)submitFeedback:(id)sender {
    if (![self.comment.text isEqualToString:@""]) {
        
        NSLog(@"%@",self.comment.text);
    
        NSString *urlstring =[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/Event_Feedback.php?EventId=%@&UserId=%@&Event=%d&Venu=%d&Catering=%d&SpeakerOverall=%d&ContentOverall=%d&comment=%@",eventId,userID,(int)self.eventS.value,(int)self.venuS.value,(int)self.cateringS.value,(int)self.speakerS.value,(int)self.contentS.value,self.comment.text];
        urlstring = [urlstring stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSLog(@"%@",urlstring);
    NSURL *url = [NSURL URLWithString:urlstring];
        
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:kNilOptions error:nil];
    
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([[json[0]valueForKey:@"message"] isEqualToString:@"Updated Successfully"] ||[[json[0]valueForKey:@"message"] isEqualToString:@"Uploded Successfully"]) {
        
        NSLog(@"submit Feeback %@",json);
        UIAlertController *ac= [UIAlertController alertControllerWithTitle:@"Synchron" message:@"Thank you for your valuable feedback" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [ac addAction:ok];
        [self presentViewController:ac animated:YES completion:nil];
        
    }else if([[json[0]valueForKey:@"message"] isEqualToString:@"Not Inserted"] ){
        NSLog(@"Error : Data is Null : %@",json);
        [self alertViewMessage:@"You cannot send feedback as you did not update RSVP status to Atending"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    }else{
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Synchron" message:@"Please comment" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [al show];
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
    NSMutableArray * Details = [[NSMutableArray alloc]init];
     Details = [NSJSONSerialization dataWithJSONObject:self.jsonData options:kNilOptions error:nil];
    
    float event = [[Details[0] valueForKey:@"EventRank"] floatValue];
    float venu = [[Details[0] valueForKey:@"VenueRank"] floatValue];
    float Cat = [[Details[0] valueForKey:@"CateringRank"] floatValue];
    float SpOall = [[Details[0] valueForKey:@"SpeakerOverallRank"] floatValue];
    float CnOall = [[Details[0] valueForKey:@"ContentOverallRank"] floatValue];
    NSString * comment = [NSString stringWithFormat:@"%@",[Details[0] valueForKey:@"Comment"] ];
    
    [self.eventS setValue:event animated:YES];
    [self.venuS setValue:event animated:YES];
    [self.cateringS setValue:event animated:YES];
    [self.speakerS setValue:event animated:YES];
    [self.contentS setValue:event animated:YES];
    
    self.EventL.text = [NSString stringWithFormat:@"%d",(int)event];
    self.VenuL.text = [NSString stringWithFormat:@"%d",(int)venu];
    self.CateringL.text = [NSString stringWithFormat:@"%d",(int)Cat];
    self.SpeakerL.text = [NSString stringWithFormat:@"%d",(int)SpOall];
    self.ContentL.text = [NSString stringWithFormat:@"%d",(int)CnOall];
    self.comment.text = [NSString stringWithFormat:@"%@",comment];
    
    [self viewDidLayoutSubviews];
                                
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)eventSm:(id)sender {
    self.EventL.text=[NSString stringWithFormat:@"%d",(int)self.eventS.value];
}
-(IBAction)venuSm:(id)sender{
     self.VenuL.text=[NSString stringWithFormat:@"%d",(int)self.venuS.value];
}

-(IBAction)cateringSm:(id)sender{
    self.CateringL.text=[NSString stringWithFormat:@"%d",(int)self.cateringS.value];
}
-(IBAction)speakerSm:(id)sender{
    self.SpeakerL.text=[NSString stringWithFormat:@"%d",(int)self.speakerS.value];
}
-(IBAction)contentSm:(id)sender{
    self.ContentL.text=[NSString stringWithFormat:@"%d",(int)self.contentS.value];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    //[self.userName resignFirstResponder];
    //[self.passWord resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    // self.scrlViewUI.contentOffset = CGPointMake(0, textField.frame.origin.y);
    CGSize iOSScreenSize=[[UIScreen mainScreen]bounds].size;
    if (iOSScreenSize.height ==736) {
        [self.scrollView setContentOffset:CGPointMake(0,316) animated:YES];
    }else{
    [self.scrollView setContentOffset:CGPointMake(0,416) animated:YES];
    }
    //tes=YES;
    [self viewDidLayoutSubviews];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.scrollView setContentOffset:CGPointMake(0,316) animated:YES];
    //tes=YES;
    [self viewDidLayoutSubviews];
}
-(void)alertViewMessage:(NSString*)message{
    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Synchron" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alrt show];
}
@end
