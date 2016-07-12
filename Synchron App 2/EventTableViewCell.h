//
//  EventTableViewCell.h
//  Synchron
//
//  Created by NCPL Inc on 05/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *attendancy;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;

@property (weak, nonatomic) IBOutlet UILabel *eventAdd;
@property (weak, nonatomic) IBOutlet UIImageView *cellBgImage;

@property (weak, nonatomic) IBOutlet UIImageView *attendingStatusImg;
@property (weak, nonatomic) IBOutlet UILabel *date_time;


@end
