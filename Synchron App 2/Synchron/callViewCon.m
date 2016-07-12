//
//  callViewCon.m
//  Synchron
//
//  Created by NCPL Inc on 05/05/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "callViewCon.h"
#import "SWRevealViewController.h"

@interface callViewCon ()
- (IBAction)CallSynchron:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *Number;
@property (weak, nonatomic) IBOutlet UIButton *menu;

@end

@implementation callViewCon

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CallSynchron:(id)sender {
    NSLog(@"%@",self.Number.text);
    NSString *phoneNumber = self.Number.text;
    NSURL *phoneUrl = [NSURL URLWithString:[@"telprompt://" stringByAppendingString:phoneNumber]];
    if([UIApplication.sharedApplication canOpenURL:phoneUrl]){
        [[UIApplication sharedApplication]openURL:phoneUrl];
    }else{
        NSLog(@" call Url: %@",phoneUrl);
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Synchron" message:@"Not able to Call" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [ alrt show] ;
    }
    
    
}
@end
