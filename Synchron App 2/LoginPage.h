//
//  LoginPage.h
//  Synchron
//
//  Created by NCPL Inc on 24/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPage : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *signIn;

@property (weak, nonatomic) IBOutlet UIButton *checkbox;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

- (IBAction)signIn1:(id)sender;
- (IBAction)saveUser:(id)sender;

@end
