//
//  UsermenuTableViewCell.h
//  Synchron
//
//  Created by NCPL Inc on 06/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsermenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPosition;
@property (weak, nonatomic) IBOutlet UILabel *userAddress;

@end
