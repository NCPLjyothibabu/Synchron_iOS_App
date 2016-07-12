//
//  SpeakerTableCell.h
//  Synchron
//
//  Created by NCPL Inc on 28/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakerTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *speakerName;
@property (weak, nonatomic) IBOutlet UILabel *speakerDesig;
@property (weak, nonatomic) IBOutlet UILabel *speakerAbout;


@end
