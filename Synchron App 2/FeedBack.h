//
//  FeedBack.h
//  Synchron
//
//  Created by NCPL Inc on 29/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDAO.h"
#import "EventFeedback.h"
#import "SpeakersFeedback.h"


@interface FeedBack : UIViewController<UIScrollViewDelegate>
@property(nonatomic,strong)UINavigationController *navigation;
- (IBAction)back:(id)sender;

@property EventDAO *eventDao;
@property NSMutableArray *eventDetails;
- (IBAction)EventFeedback:(id)sender;
- (IBAction)Speakersfeedback:(id)sender;


@end
