//
//  EventFeedback.h
//  Synchron
//
//  Created by NCPL Inc on 29/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDAO.h"
#import "SpeakersFeedback.h"
#import "ContentFeedback.h"

@interface EventFeedback : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventAddress;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;

@property (weak, nonatomic) IBOutlet UILabel *EventL;
@property (weak, nonatomic) IBOutlet UILabel *VenuL;
@property (weak, nonatomic) IBOutlet UILabel *CateringL;
@property (weak, nonatomic) IBOutlet UILabel *SpeakerL;
@property (weak, nonatomic) IBOutlet UILabel *ContentL;

@property (weak, nonatomic) IBOutlet UISlider *eventS;
@property (weak, nonatomic) IBOutlet UISlider *venuS;
@property (weak, nonatomic) IBOutlet UISlider *cateringS;
@property (weak, nonatomic) IBOutlet UISlider *speakerS;
@property (weak, nonatomic) IBOutlet UISlider *contentS;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property EventDAO *eventdao;
@property NSMutableArray *EventDetails;
@property NSString *userID;
@property
NSString *eventId;
@property (weak, nonatomic) IBOutlet UITextField *comment;



- (IBAction)speaker:(id)sender;

- (IBAction)content:(id)sender;

- (IBAction)submitFeedback:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)eventSm:(id)sender;
- (IBAction)venuSm:(id)sender;
- (IBAction)cateringSm:(id)sender;
- (IBAction)speakerSm:(id)sender;
- (IBAction)contentSm:(id)sender;
@end
