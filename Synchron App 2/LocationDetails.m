//
//  LocationDetails.m
//  Synchron
//
//  Created by NCPL Inc on 29/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "LocationDetails.h"
#import "SWRevealViewController.h"
#import "Events.h"
@interface LocationDetails ()

@end

@implementation LocationDetails
@synthesize sidebarButton,btn1;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    } */
  //  Events *event=[Events new];
    [btn1 addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    

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

@end
