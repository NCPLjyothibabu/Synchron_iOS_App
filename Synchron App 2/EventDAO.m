//
//  EventDAO.m
//  Synchron
//
//  Created by NCPL Inc on 13/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "EventDAO.h"

@implementation EventDAO
@synthesize EventAddress,EventImage,EventTitle,EventId,EventAttending,AttendingStatus,Date_Time;

-(id)initWithEventTitle:(NSString *)evTitleEvent Address:(NSString *)evAddress EvImage:(NSString *)evImage EventID:(NSString *)evId EventAtt:(NSString *)eventAtt AttengingStatus:(NSString*)attStatus Date_Time:(NSString*)date_time{
    [self superclass];
    if (self) {
        EventId= evId;
        EventTitle = evTitleEvent;
        EventAddress = evAddress;
        EventImage=evImage;
        EventAttending =eventAtt;
        AttendingStatus = attStatus;
        Date_Time = date_time;
    }
    return self;
}
@end
