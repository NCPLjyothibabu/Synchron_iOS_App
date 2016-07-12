//
//  EventDAO.h
//  Synchron
//
//  Created by NCPL Inc on 13/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventDAO : NSObject

@property NSString *EventTitle;
@property NSString *EventAddress;
@property NSString *EventImage;
@property NSString *EventId;
@property NSString *EventAttending;
@property NSString* AttendingStatus;
@property NSString *Date_Time;

-(id)initWithEventTitle:(NSString*)evTitleEvent Address:(NSString*)evAddress EvImage:(NSString*)evImage EventID:(NSString*)evId EventAtt:(NSString*)eventAtt AttengingStatus:(NSString*)attStatus Date_Time:(NSString*)date_time;
@end
