//
//  EditProfileViewController.h
//  Synchron
//
//  Created by NCPL Inc on 31/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate>
@property(nonatomic,strong)IBOutlet UIScrollView *scroll;
@property(strong,nonatomic) IBOutlet UIButton*main;
@property (strong,nonatomic) IBOutlet UIImageView *profilePic;

@property (strong, nonatomic) IBOutlet UITextField *fullname;
@property (strong, nonatomic) IBOutlet UITextField *profession;
@property (strong, nonatomic) IBOutlet UITextField *location;

@property (strong, nonatomic) IBOutlet UITextField *emailID;
@property (strong, nonatomic) IBOutlet UITextField *landPhone;
@property (strong, nonatomic) IBOutlet UITextField *mobilePhone;

@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *newpassword;
@property (strong, nonatomic) IBOutlet UITextField *re_newpassword;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)back:(id)sender;
-(IBAction)saveback:(id)sender;

- (IBAction)replacePic:(id)sender;

@end
