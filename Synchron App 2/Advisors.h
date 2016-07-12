//
//  Advisors.h
//  Synchron
//
//  Created by NCPL Inc on 01/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface Advisors : UIViewController <SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *adviserMenu;
@property (weak, nonatomic) IBOutlet UIButton *adviserComment;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;

@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *titile;

@property (weak, nonatomic) IBOutlet UILabel *city_country;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *Office;

@property (weak, nonatomic) IBOutlet UITextView *about;
- (IBAction)backbutton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *circelImage;
@property (weak, nonatomic) IBOutlet UILabel *UserName;


@property NSDictionary *data;



@end
