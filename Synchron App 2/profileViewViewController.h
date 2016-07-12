//
//  profileViewViewController.h
//  Synchron
//
//  Created by NCPL Inc on 21/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface profileViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *menu;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *fullname;
@property (weak, nonatomic) IBOutlet UILabel *designation;
@property (weak, nonatomic) IBOutlet UILabel *cityCountry;
@property (weak, nonatomic) IBOutlet UILabel *emailId;
@property (weak, nonatomic) IBOutlet UILabel *landPhone;
@property (weak, nonatomic) IBOutlet UILabel *mobilePhone;

@property (weak, nonatomic) IBOutlet UILabel *password;
- (IBAction)editProfile:(id)sender;
@end
