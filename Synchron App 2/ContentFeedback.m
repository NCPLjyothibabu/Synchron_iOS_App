//
//  ContentFeedback.m
//  Synchron
//
//  Created by NCPL Inc on 18/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "ContentFeedback.h"

@interface ContentFeedback ()

@end

@implementation ContentFeedback
@synthesize EventDetails,userId,evenId,ContentscrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.ContentscrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+568);
    [self performSelectorInBackground:@selector(fetchData) withObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
-(IBAction)submitFeedback:(id)sender{
    
}
@end
