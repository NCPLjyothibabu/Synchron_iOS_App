//
//  EditProfileViewController.m
//  Synchron
//
//  Created by NCPL Inc on 31/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "EditProfileViewController.h"
#import "SWRevealViewController.h"
#import "Events.h"
#import "profileViewViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Parse/Parse.h>
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"
//#import "JSON.h"
@interface EditProfileViewController (){
    
}
@property NSData *jsondata;
@property UIActivityIndicatorView *spinner;
@property UITableView* table;
@property NSMutableArray *proffArray;
@property UIView *backView;
@property int profInt;
@property PFUser *user;
@property BOOL imageSelected;
@property NSString *oldImageUrl;
@end


@implementation EditProfileViewController
@synthesize  scroll,main,spinner,user, imageSelected, oldImageUrl;
- (void)viewDidLoad {
    [super viewDidLoad];
    user= [PFUser currentUser];
    [self getDatafromParse];
    [main addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [spinner setColor:[UIColor blackColor]];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:scroll];
    [scroll addSubview:spinner];
    
    [spinner startAnimating];
    
    [scroll setScrollEnabled:YES];
    
    CGSize iosScreenSize = [[UIScreen mainScreen]bounds].size;
    if (iosScreenSize.height == 736) {
        [scroll setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+200)];
    }else if (iosScreenSize.height == 568 || iosScreenSize.height == 480 ) {
        [scroll setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*2)];
    }else{
    
    [scroll setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+(self.view.bounds.size.height/2))];
    }
 //[[NSUserDefaults standardUserDefaults]setObject:userID forKey:@"UserId"];
    // Do any additional setup after loading the view.
    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/get_userdetails.php?user_id=%@",UserId]];
    NSLog(@" Url Is : %@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    self.imageView.layer.borderWidth= 2.0f;
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(self.profession.frame.origin.x, self.profession.frame.origin.y, 250, 150) style:UITableViewStylePlain];

    _table.rowHeight = 45;
    _table.sectionFooterHeight = 22;
    _table.sectionHeaderHeight = 22;
    _table.scrollEnabled = YES;
    _table.showsVerticalScrollIndicator = YES;
    _table.userInteractionEnabled = YES;
    _table.bounces = YES;
    _table.layer.cornerRadius = 10;
    _table.layer.borderWidth = 4;
    _table.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor darkGrayColor]);
    _table.backgroundColor = [UIColor lightGrayColor];
    
    _table.delegate = self;
    _table.dataSource = self;
 [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"newCell"];
//    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    self.backView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_table];
    
    
    self.table.hidden =YES;
    _proffArray = [[NSMutableArray alloc]initWithObjects:@"Advisor",@"Business Partner", nil];
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

- (IBAction)back:(id)sender
{
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
    
  //  profileViewViewController *profile = [profileViewViewController new];
    
  //  [self.navigationController popToViewController:
  //  profile animated:YES];
   // [self.navigationController popViewControllerAnimated:YES];
    
  
     // [self.navigationController pushViewController:[profileViewViewController new] animated:YES];
    
    
    
  //  profileViewViewController *profile = [profileViewViewController new];
 //   [profile.navigationController popViewControllerAnimated:YES];
    
    
}
-(IBAction)saveback:(id)sender
{
  
  //  www.synchron.6elements.net/webservices/update_profile.php?UserId=22&firstName=swamy&proffesion=Business Partners&location=14-12-88.Maharani peta,Near Duvii travels,Ottageda,R.k Beach&phone=8923446555&mobile=8976543233&password=sari@123&newPassword=sari@123&reEnterPassword=sari@123&profilepic=Koala1.jpg
    NSString *imageUrl ;
    if (imageSelected) {
        
        PFFile *ImgFile = user[@"UserImage"];
       
        imageUrl = [NSString stringWithFormat:@"%@",ImgFile.url];
    }else{
        imageUrl = oldImageUrl;
    }
    
    
    if ([self.fullname.text isEqualToString:@""]||[self.location.text isEqualToString:@""]||[self.landPhone.text isEqualToString:@""]||[self.mobilePhone.text isEqualToString:@""]||[self.password.text isEqualToString:@""]||[self.newpassword.text isEqualToString:@""]||[self.re_newpassword.text isEqualToString:@""]) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Synchron" message:@"Please provide all details" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alrt show];
    }else{
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];

    
    NSString *urlstring =[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/update_profile.php?UserId=%@&firstName=%@&proffesion=%d&location=%@&phone=%@&mobile=%@&password=%@&newPassword=%@&reEnterPassword=%@&profilepic=%@",userID,self.fullname.text,self.profInt,self.location.text,self.landPhone.text,self.mobilePhone.text,self.password.text,self.newpassword.text, self.re_newpassword.text,imageUrl];
    urlstring = [urlstring stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"%@",urlstring);
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSData new];
    NSError *err;
     data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
   // data =[NSURLConnection sendSynchronousRequest:request returningResponse:kNilOptions error:nil];
    if (data!=nil) {
        NSLog(@"Data is:%@",data);
        NSMutableArray * jsonResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"Out put ; %@",jsonResponce);
        NSString *result = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"message"]];
        
//        user[@"UserFullname"] =self.fullname.text;
//        user[@"UserPossition"] = self.profession.text;
//        user[@"UserAddress"] = self.location.text;
////        self.emailID.text = user.email;
////        self.emailID.enabled =NO;
//        user[@"UserMobile"] = self.mobilePhone.text;
//        user[@"UserOffice"] = self.landPhone.text;
//        user.password = self.password.text;
//        BOOL U = [user save];
        if ([result isEqualToString:@"Updated Successfully"]) {
             //NSData *in = [NSData dataWithContentsOfFile:ImgFile];
            PFFile *ImgFile1 = user[@"UserImage"];
            NSData *imgdata = [NSData dataWithData:ImgFile1.getData];
            [[NSUserDefaults standardUserDefaults]setObject:imgdata forKey:@"UserImage"];

            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Synchron" message:@"your details uploaded" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alrt show];
            //NSLog(@"Saved in Parse ?? %@",U);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Synchron" message:@"Error occured in updating details, please try again" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alrt show];
        }
    }else{
        NSLog(@" data is Null");
    }
  }
//    NSLog(@"Data is:%@",data);
//    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    
//    NSLog(@"Information Sent is :%@",json);
    
    
   
}

//-(void)AsihttpReq{
//    
//     NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"MMddyyyy"];
//    NSString *newDateString = [dateFormatter stringFromDate:[NSDate date]];
//    
//    NSString *imageName=[NSString stringWithFormat:@"%@_%@.jpg",self.fullname.text,newDateString];
//    NSString *urlString=[NSString stringWithFormat:@"www.synchron.6elements.net/webservices/update_profile.php?UserId=%@&firstName=%@&proffesion=%@&location=%@&phone=%@&mobile=%@&password=sari@123&newPassword=sari@123&reEnterPassword=sari@123&profilepic=%@",userID,self.fullname.text,self.profession.text,self.location.text,self.landPhone.text,self.mobilePhone.text,imageName];
//    NSData * imageData = UIImageJPEGRepresentation(self.imageView.image, 1);
//    
//    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
//    
//    [request setUseKeychainPersistence:YES];
//    
//    
//    //[request setPostValue:self.fullname.text forKey:@"fullname"];
//    
//   
//    
//    [request setData:imageData withFileName:imageName andContentType:@"image/jpg" forKey:@"profilepic"];
//    
//    
//    [request setRequestMethod:@"POST"];
//    [request setDelegate:self];
//    [request setDidFinishSelector:@selector(UploadRequestFinished:)];
//    [request setDidFailSelector:@selector(uploadRequestFailed:)];
//    [request startAsynchronous];
//    
//
//}
//-(void)UploadRequestFinished:(ASIHTTPRequest *)request
//{
//    NSString *receivedString = [request responseString];
//    
//    NSArray *arrSepr=[receivedString componentsSeparatedByString:@"+"];
//    
//    NSLog(@"arrSepr is %@",arrSepr);
//    
//    
//    
//    if ([receivedString isEqualToString:@"success"]) {
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        
//       // [self alertviewtitle:@"Whirld" message:receivedString];
//    }
//}
//-(void)uploadRequestFailed:(ASIHTTPRequest *)request{
//    NSString *receivedString = [request responseString];
//    NSArray *arrSepr=[receivedString componentsSeparatedByString:@"+"];
//    NSLog(@"Error is %@",arrSepr);
//}

- (IBAction)replacePic:(id)sender {
    
    UIAlertController *Imagereplace = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *lib = [UIAlertAction actionWithTitle:@"Choose form Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self libraryImage];
    }];
    UIAlertAction *cam = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cameraImage];
    }];
    
    [Imagereplace addAction:cancel];
    [Imagereplace addAction:lib];
    [Imagereplace addAction:cam];
    [self presentViewController:Imagereplace animated:YES completion:nil];
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
    
    NSString * img = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@" Profile Image"]];
    oldImageUrl = img;
    NSData *imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    NSString * firstName = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Firstname"]];
    NSString * lastName = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Lastname"]];
    NSString * position = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"User Position"]];
    if ([position isEqualToString:@"Advisor"]) {
        _profInt = 1;
    }else if ([position isEqualToString:@"Business Partners"]){
        _profInt =2;
    }
   // NSString * address= [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Address "]];
    NSString * emailId = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Email Id"]];
    NSString * phone = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Phone Number"]];
    NSString * mobile = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Mobile Number"]];
    NSString * password = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Password"]];
    NSString * city = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"City"]];
    NSString * country = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Country"]];
    
    if (imgdata !=NULL) {
//        self.profilePic.image = [UIImage imageWithData:imgdata];
        self.imageView.image =[UIImage imageWithData:imgdata];
    }else{
//        self.profilePic.image = [UIImage imageNamed:@"profile.png"];
        self.imageView.image = [UIImage imageNamed:@"profile.png"];
    }
    
  
    self.fullname.text = firstName;
    self.profession.text = position;
    self.location.text = [NSString stringWithFormat:@"%@,%@",city,country];
    self.emailID.text = emailId;
    self.emailID.enabled =NO;
    self.mobilePhone.text = mobile;
    self.landPhone.text = phone;
    self.password.text = password;
    
    [spinner stopAnimating];
    
}

#pragma mark TableView methods.

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _proffArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = @"newCell";
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (Cell== nil) {
        Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    Cell.textLabel.text = _proffArray[indexPath.row];
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.profession.text = _proffArray[indexPath.row];
    if ([_proffArray[indexPath.row] isEqualToString:@"Advisor"]) {
        _profInt = 1;
    }else if ([_proffArray[indexPath.row] isEqualToString:@"Business Partner"]){
        _profInt =2;
    }else{
        _profInt =1;
    }
    self.table.hidden = YES;
}

#pragma mark TextField methods.

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    //[self.userName resignFirstResponder];
    //[self.passWord resignFirstResponder];
    return YES;
}


    
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    // self.scrlViewUI.contentOffset = CGPointMake(0, textField.frame.origin.y);
    if ([textField isEqual:self.profession]) {
        
        
    }else
    {
        CGSize iOSScreenSize=[[UIScreen mainScreen]bounds].size;
    if (iOSScreenSize.height==480)
    {
        [self.scroll setContentOffset:CGPointMake(0,textField.center.y-150) animated:YES];
    }
    if (iOSScreenSize.height==568)
    {
        [self.scroll setContentOffset:CGPointMake(0,textField.center.y-150) animated:YES];
    }else{
    
  
    [self.scroll setContentOffset:CGPointMake(0,textField.center.y-180) animated:YES];
   }
    //tes=YES;
    [self viewDidLayoutSubviews];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.scroll setContentOffset:CGPointMake(0,70) animated:YES];
    //tes=YES;
    [self viewDidLayoutSubviews];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.fullname resignFirstResponder];
    [self.profession resignFirstResponder];
    [self.location resignFirstResponder];
    [self.emailID resignFirstResponder];
    
    [self.mobilePhone resignFirstResponder];
    [self.landPhone resignFirstResponder];
    [self.password resignFirstResponder];
}

#pragma Image Picker



-(void)cameraImage{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    } else {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //picker
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
}

-(void)libraryImage{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
//    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
//    //NSString *imageName = [imagePath lastPathComponent];
//    NSLog(@"image name %@",imagePath);
   // NSData *imgdata = [NSData dataWithContentsOfURL:imagePath];
    PFFile *img = [PFFile fileWithData:UIImagePNGRepresentation(chosenImage)];
    user[@"UserImage"]= img;
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        imageSelected= YES;
    }];
   // NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
   
    
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)proffSelectBtn:(id)sender {
    [self.profession resignFirstResponder];
    [self.fullname resignFirstResponder];
    [self.profession resignFirstResponder];
    [self.location resignFirstResponder];
    [self.emailID resignFirstResponder];
    
    [self.mobilePhone resignFirstResponder];
    [self.landPhone resignFirstResponder];
    [self.password resignFirstResponder];
    _table.hidden = NO;
}
-(void)getDatafromParse{
    
    self.fullname.text = user[@"UserFullname"];
    self.profession.text = user[@"UserPossition"];
    self.location.text = user[@"UserAddress"];
    self.emailID.text = user.email;
    self.emailID.enabled =NO;
    self.mobilePhone.text = user[@"UserMobile"];
    self.landPhone.text = user[@"UserOffice"];
    self.password.text = user.password;
}

@end
