//
//  profileViewViewController.m
//  Synchron
//
//  Created by NCPL Inc on 21/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "profileViewViewController.h"
#import "EditProfileViewController.h"
#import <Parse/Parse.h>
@interface profileViewViewController ()
@property NSData *jsondata;
@property UIActivityIndicatorView *spinner;
@end

@implementation profileViewViewController
@synthesize spinner;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2;
    self.profilePic.clipsToBounds = YES;
    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/get_userdetails.php?user_id=%@",UserId]];
    NSLog(@" Url Is : %@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [spinner setColor:[UIColor blackColor]];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    //[scroll addSubview:spinner];
    
    [spinner startAnimating];
    //[self displaydata];
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
-(void)displaydata{
    PFUser *user = [PFUser currentUser];

    
    self.fullname.text = user[@"UserFullName"];
    self.designation.text = user[@"UserPosition"];
    self.cityCountry.text =user[@"UserAddress"];

    if (user[@"UserImage"] !=NULL) {
        PFFile *img = user[@"UserImage"];
        NSData *ImgData = [NSData dataWithContentsOfURL:img.url];
        self.profilePic.image = [UIImage imageWithData:ImgData];
    }else{
        self.profilePic.image = [UIImage imageNamed:@"profile.png"];
    }
   // self.profilePic.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"]];
    
    
    
    
    self.emailId.text= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserEmail"]];
    self.landPhone.text =user[@"UserMobile"];
    self.mobilePhone.text=user[@"UserOffice"];
    
    
    
}


- (IBAction)editProfile:(id)sender {
    //[self performSegueWithIdentifier:@"edit" sender:self];
    EditProfileViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"EditView"];
    [self.navigationController pushViewController:edit animated:YES];
}
   
    - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
        NSLog(@" In Did receive Response");
        self.jsondata  = [[NSData alloc]init];
    }

    - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
        NSLog(@" In Did receive Data");
        self.jsondata = [NSData dataWithData:data];
    }
    
    
    - (void)connectionDidFinishLoading:(NSURLConnection *)connection{
        NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:self.jsondata options:kNilOptions error:nil];
        NSLog(@"Json in Edit Profile:%@",jsonArray);
        
        self.fullname.text = [jsonArray[0]objectForKey:@"Firstname"];
        self.designation.text = [jsonArray[0]objectForKey:@"User Position"];
        self.cityCountry.text =[jsonArray[0]objectForKey:@"City"];
        
        if ([[jsonArray[0]objectForKey:@" Profile Image"] isEqualToString:@""]) {
            self.profilePic.image = [UIImage imageNamed:@"profile.png"];
        }else{
            
            NSURL *url = [NSURL URLWithString:[jsonArray[0]objectForKey:@" Profile Image"]];
            NSData *ImgData = [NSData dataWithContentsOfURL:url];
            self.profilePic.image = [UIImage imageWithData:ImgData];
        }
        // self.profilePic.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"]];
        
        
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2;
        self.profilePic.clipsToBounds = YES;
        
        self.emailId.text= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserEmail"]];
        self.landPhone.text =[jsonArray[0]objectForKey:@"Phone Number"];
        self.mobilePhone.text= [jsonArray[0]objectForKey:@"Mobile Number"];
        [ spinner stopAnimating];
        
    }
@end
