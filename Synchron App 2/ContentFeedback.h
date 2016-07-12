//
//  ContentFeedback.h
//  Synchron
//
//  Created by NCPL Inc on 18/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentFeedback : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventAddress;
@property (weak, nonatomic) IBOutlet UILabel *s1;
@property (weak, nonatomic) IBOutlet UILabel *s2;
@property (weak, nonatomic) IBOutlet UILabel *s3;
@property (weak, nonatomic) IBOutlet UILabel *s4;
@property (weak, nonatomic) IBOutlet UILabel *s5;

@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider4;
@property (weak, nonatomic) IBOutlet UISlider *slider5;

@property NSMutableArray *EventDetails;

@property NSString *userId;
@property NSString *evenId;
@property (strong, nonatomic) IBOutlet UIScrollView *ContentscrollView;

- (IBAction)submitFeedback:(id)sender;
- (IBAction)spaker1M:(id)sender;
- (IBAction)spaker2M:(id)sender;
- (IBAction)spaker3M:(id)sender;
- (IBAction)spaker4M:(id)sender;
- (IBAction)spaker5M:(id)sender;
- (IBAction)back:(id)sender;
@end
