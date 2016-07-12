//
//  SpeakersFeedback.m
//  Synchron
//
//  Created by NCPL Inc on 29/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "SpeakersFeedback.h"
#import "SWRevealViewController.h"
@interface SpeakersFeedback ()

@end


@implementation SpeakersFeedback
@synthesize EventDetails,userId,evenId,SpeakerscrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
//    SWRevealViewController *revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
////        [self.sidebarButton setTarget: self.revealViewController];
////        [self.sidebarButton setAction: @selector( revealToggle: )];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
    // Do any additional setup after loading the view.
    
    
   // SpeakerscrollView = [UIScrollView new];
    
  //  [SpeakerscrollView setScrollEnabled:YES];
    
//[SpeakerscrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+700)];
    
    
   // [SpeakerscrollView setContentSize:CGSizeMake(self.view.frame.size.width, 800)];
    
    
    
    
    
    
    
    
    
    
    
self.SpeakerscrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+568);
    
    
    
//    SpeakerscrollView = [[UIScrollView alloc]init];
// //   SpeakerscrollView.frame = self.view.bounds; //scroll view occupies full parent view!
//    //specify CGRect bounds in place of self.view.bounds to make it as a portion of parent view!
//    
//    SpeakerscrollView.contentSize = CGSizeMake(400, 800);   //scroll view size
//    
//   // SpeakerscrollView.backgroundColor = [UIColor grayColor];
//    
//   SpeakerscrollView.showsVerticalScrollIndicator = YES;    // to hide scroll indicators!
//    
//   // SpeakerscrollView.showsHorizontalScrollIndicator = YES; //by default, it shows!
//    
//   // SpeakerscrollView.scrollEnabled = YES;                 //say "NO" to disable scroll
//    
//    
//              //adding to parent view!
//
//    [self.view addSubview:SpeakerscrollView];
    [self performSelectorInBackground:@selector(fetchData) withObject:nil];
  
}
-(void)fetchData{
    NSLog(@" in speaker Details: %@",EventDetails);
    
    NSString *eventTitle = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventName"]];
    NSString* address = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventAddress"]];
    userId =[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    evenId = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventId"]];
    
    NSString *img = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventLogo"]];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:img]];
    self.eventTitle.text = eventTitle;
    self.eventAddress.text =address;
    self.imageView.image = [UIImage imageWithData:imageData];
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

- (IBAction)submitFeedback:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/speaker_feedback.php?eventid=%@&userid=%@&speaker1=%d&speaker2=%d&speaker3=%d&speaker4=%d&speaker5=%d",evenId,userId,(int)self.slider1.value,(int)self.slider2.value,(int)self.slider3.value,(int)self.slider4.value,(int)self.slider5.value]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:kNilOptions error:nil];
    
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (json!=nil) {
        
        UIAlertController *ac= [UIAlertController alertControllerWithTitle:@"Synchron" message:@"Thank you for your valuable feedback" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [ac addAction:ok];
        [self presentViewController:ac animated:YES completion:nil];
        
    }
}

- (IBAction)spaker1M:(id)sender {
    self.s1.text = [NSString stringWithFormat:@"%d",(int)self.slider1.value];
}
- (IBAction)spaker2M:(id)sender {
    self.s2.text = [NSString stringWithFormat:@"%d",(int)self.slider2.value];
}
- (IBAction)spaker3M:(id)sender {
    self.s3.text = [NSString stringWithFormat:@"%d",(int)self.slider3.value];
}
- (IBAction)spaker4M:(id)sender {
    self.s4.text = [NSString stringWithFormat:@"%d",(int)self.slider4.value];
}
- (IBAction)spaker5M:(id)sender {
    self.s5.text = [NSString stringWithFormat:@"%d",(int)self.slider5.value];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
