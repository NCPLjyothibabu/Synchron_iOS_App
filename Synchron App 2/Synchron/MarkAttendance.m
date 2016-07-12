//
//  MarkAttendance.m
//  Synchron
//
//  Created by NCPL Inc on 27/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "MarkAttendance.h"
#import "SWRevealViewController.h"

@interface MarkAttendance ()

@end

@implementation MarkAttendance

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self performSelectorInBackground:@selector(Loadimage) withObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Loadimage{
    //[[NSUserDefaults standardUserDefaults]setObject:userID forKey:@"UserId"];
    
    NSString * userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];

    NSLog(@" User Id : %@",userId);
    //NSString * QRImg = [NSString stringWithFormat:@"%@",BPartners];
  
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/phpqrcode/index.php?id=33"]];
    NSURLRequest *prequest = [NSURLRequest requestWithURL:url];
    NSData *pdata = [[NSData alloc]init];
    NSMutableArray *BPartners= [[NSMutableArray alloc]init];
    pdata = [NSURLConnection sendSynchronousRequest:prequest returningResponse:nil error:nil];
    BPartners = [NSJSONSerialization JSONObjectWithData:pdata options:kNilOptions error:nil];
    NSLog(@" Partnerts Are : %@",BPartners);
    
    
    NSString *QrString = [NSString stringWithFormat:@"%@",[BPartners[0] valueForKey:@"Qrcode"]];
    NSURL *urlimg = [NSURL URLWithString:QrString];
    NSLog(@" Url: %@",urlimg);
    NSData *imgdata = [NSData dataWithContentsOfURL:urlimg];
    self.QRImage.image = [UIImage imageWithData:imgdata];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
