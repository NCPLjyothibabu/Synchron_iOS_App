//
//  FeedBack.m
//  Synchron
//
//  Created by NCPL Inc on 29/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "FeedBack.h"
#import "Events.h"
#import "EventDAO.h"

@interface FeedBack ()
- (IBAction)backEvent:(id)sender;
- (IBAction)back:(id)sender;

@end

@implementation FeedBack
@synthesize navigation;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    navigation=[[UINavigationController alloc]init];
    // Do any additional setup after loading the view.
 // EventDAO * ev = self.eventDao;
   // self.eventDetails = [NSMutableArray new];
    NSLog(@" submit Feeback : %@",self.eventDetails);
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

- (IBAction)backEvent:(id)sender {
   // Events *previosVC = [[Events alloc]init];
  //  [self.navigationController popViewControllerAnimated:YES]; // go to previous view controller
    //[self.navigationController popToRootViewControllerAnimated:YES]; // go to root view controller
  //  [self.navigationController popToViewController:previosVC animated:YES]; // go to any view controller
   // [previosVC release];
   // [self.navigationController popToViewController:previosVC animated:YES];
  //  [self popoverPresentationController:previosVC];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)EventFeedback:(id)sender {
   // UINavigationController *navController = [[UINavigationController alloc]init];

//    EventFeedback * evfb = [self.storyboard instantiateViewControllerWithIdentifier:@"EventFeedback"];
//    evfb.EventDetails = self.eventDetails;
//    [self.navigationController presentViewController:evfb animated:YES completion:nil];
    EventFeedback *ev = [[EventFeedback alloc]init];
    ev.EventDetails = self.eventDetails;
    [ self performSegueWithIdentifier:@"eventFB" sender:self];
    
}

- (IBAction)Speakersfeedback:(id)sender {
    
//    SpeakersFeedback *spfb = [self.storyboard instantiateViewControllerWithIdentifier:@"SpeakersFeedback"];
//    spfb.EventDetails = self.eventDetails;
//    [self.navigationController presentViewController:spfb animated:YES completion:nil]; speakerFB
    SpeakersFeedback *ev = [[SpeakersFeedback alloc]init];
    ev.EventDetails = self.eventDetails;
    [ self performSegueWithIdentifier:@"speakerFB" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier ] isEqualToString:@"speakerFB"]) {
        SpeakersFeedback *sf = [segue destinationViewController];
        //sf.EventDetails= self.eventDetails;
        [sf setEventDetails:self.eventDetails];
    }
    if ([[segue identifier ] isEqualToString:@"eventFB"]) {
        EventFeedback *sf = [segue destinationViewController];
        //sf.EventDetails= self.eventDetails;
        [sf setEventDetails:self.eventDetails];
    }
}

@end
