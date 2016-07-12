//
//  Advisors.m
//  Synchron
//
//  Created by NCPL Inc on 01/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "Advisors.h"
#import "SWRevealViewController.h"
@interface Advisors ()
@property UIActivityIndicatorView *spinner;
@end

@implementation Advisors
@synthesize adviserComment,adviserMenu,spinner,circelImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@" got Details : %@",self.data);
    // Do any additional setup after loading the view.
   
   spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    //self.circelImage.layer cornerRadius
    
    self.circelImage.layer.cornerRadius = self.circelImage.frame.size.height/2;
    self.circelImage.clipsToBounds = YES;
    self.circelImage.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    self.circelImage.layer.borderWidth= 2.0f;
    

     [self performSelectorInBackground:@selector(displaydata1) withObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displaydata1{
    
    
    
    NSString * imgst = [NSString stringWithFormat:@"%@",[self.data valueForKey:@" Advisor Image"]];
    NSData *img = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgst]];
    self.imgView.image = [UIImage imageWithData:img];
    if (img!=NULL) {
        self.circelImage.image = [UIImage imageWithData:img];
    }else{
        self.circelImage.image = [UIImage imageNamed:@"profile.png"];
    }
    self.UserName.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"FirstName"]];
    self.fullName.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"FirstName"]];
    self.lastName.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"LastName"]];
    //Phone Number
    
    self.position.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"User Position"]];
    self.titile.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"User Position"]];
    self.Office.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"Phone Number"]];
    self.city_country.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"State"]];
    self.email.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"Email Id"]];
    self.mobile.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"Mobile Number"]];
    //self.state.text = [NSString stringWithFormat:@"%@",[self.data valueForKey:@"State"]];
    [spinner stopAnimating];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backbutton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
