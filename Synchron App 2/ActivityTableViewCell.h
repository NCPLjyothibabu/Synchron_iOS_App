//
//  ActivityTableViewCell.h
//  Synchron
//
//  Created by NCPL Inc on 28/06/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *MeImg;

@property (weak, nonatomic) IBOutlet UIImageView *FrndImg;
@property (weak, nonatomic) IBOutlet UIImageView *meChatImge;
@property (weak, nonatomic) IBOutlet UIImageView *FrndChatImge;
@property (weak, nonatomic) IBOutlet UILabel *ChatLable;

@end
