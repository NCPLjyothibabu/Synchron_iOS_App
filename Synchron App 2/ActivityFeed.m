//
//  ActivityFeed.m
//  Synchron
//
//  Created by NCPL Inc on 28/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "ActivityFeed.h"
#import "SWRevealViewController.h"
#import <Firebase/Firebase.h>
#import "ActivityTableViewCell.h"
#import <SDWebImageCompat.h>
#import <Parse/Parse.h>
#import <SDWebImage/UIImageView+WebCache.h>
//#import "MXLMediaView.h"
#import "URBMediaFocusViewController.h"

@interface ActivityFeed () {
    NSMutableArray *bubbleData;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property int animatedDistance;
@property (strong, atomic) NSMutableArray *ChatArray;
@property (strong, atomic) NSMutableArray *UserArray;
@property (strong, atomic) NSMutableArray *avatarArray;
@property  Firebase *myRootRef;
@property (strong, atomic) PFUser *user;
@property int chatCount;
@property (weak, nonatomic) IBOutlet UIView *textchatView;
@property URBMediaFocusViewController *mediaFocusController;

//@property (strong, nonatomic)
@end

@implementation ActivityFeed
@synthesize sidebarButton, menu, Chattextfield, myRootRef,user,chatCount,ChatTableView;


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
        
    [Chattextfield resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mediaFocusController = [[URBMediaFocusViewController alloc] init];
    self.mediaFocusController.shouldDismissOnImageTap = YES;
    self.mediaFocusController.shouldShowPhotoActions = YES;
    //self.mediaFocusController.
    CGSize iOSScreenSize=[[UIScreen mainScreen]bounds].size;
    self.UserArray = [[NSMutableArray alloc]init];
    self.ChatArray = [[NSMutableArray alloc]init];
    self.avatarArray = [[NSMutableArray alloc]init];
    
    user = [PFUser currentUser];
    NSLog(@"current user is : %@",user);
    myRootRef = [[Firebase alloc] initWithUrl:@"https://synchronchatapp.firebaseio.com"];
     Firebase *postRef = [myRootRef childByAppendingPath: @"chat"];
    [postRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"Available childerns are :%lu",(unsigned long)snapshot.childrenCount);
        chatCount = snapshot.childrenCount ;
        NSLog( @"Chat Count is %d",chatCount);
        self.UserArray= nil;
        self.ChatArray=nil;
        self.avatarArray=nil;
        [self GettingDataFromFirebase];
    }];

    Chattextfield.delegate = self;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [self setupAlertCtrl];

    }
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    [menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
   // [self bobbleinit ];
    
//    NSArray * Keys = [[NSArray alloc]initWithObjects:@"messgae",@"image",@"video",@"user", nil];
//    NSArray *obj1 = [[NSArray alloc]initWithObjects:@"hi Bro !!",@"",@"",@"me", nil];
//    NSArray *obj2 = [[NSArray alloc]initWithObjects:@"",@"meeting.png",@"",@"me", nil];
//    NSArray* obj3 = [[NSArray alloc]initWithObjects:@"",@"meeting.png",@"",@"not", nil];
//    NSDictionary *mechat = [[NSDictionary alloc]initWithObjects:obj1 forKeys:Keys];
//    NSDictionary *mechat2 = [[NSDictionary alloc]initWithObjects:obj2 forKeys:Keys];
//    NSDictionary *ntChat1 = [[NSDictionary alloc]initWithObjects:obj3 forKeys:Keys];
//    
//    NSLog(@"Dicts Are %@ : %@ :%@",mechat,mechat2,ntChat1);
//    self.ChatArray = [[NSMutableArray alloc]initWithObjects:mechat,mechat2,ntChat1, nil];
//    self.UserArray = [[NSMutableArray alloc]initWithObjects:@"not",@"me",@"not", nil];
    
    
    self.ChatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [myRootRef createUser:@"ramsarita211@gmail.com" password:@"Password"
// withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
//     
//     if (error) {
//         // There was an error creating the account
//         NSLog(@"User not Created, Trying to login : %@",error);
//         [myRootRef authUser:@"ramsarita211@gmail.com" password:@"Password"
//   withCompletionBlock:^(NSError *error, FAuthData *authData) {
//       
//       if (error) {
//           // an error occurred while attempting login
//   } else {
//           // user is logged in, check authData for data
//           NSLog(@"User loged inn : %@",authData);
//       }
//   }];
//         
//     } else {
//         NSString *uid = [result objectForKey:@"uid"];
//         NSLog(@"Successfully created user account with uid: %@", uid);
//         NSLog(@"User Created : %@",result);
//     }
// }];
    // Getting Data in chat
    //
   
//    
//    // Attach a block to read the data at our posts reference
//    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        NSLog(@"%@", snapshot.value);
//    } withCancelBlock:^(NSError *error) {
//        NSLog(@"%@", error.description);
//    }];
//
  
}

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
//    if(self.UserArray == nil){
//       
//        
//        [self GettingDataFromFirebase];
//    }else{
//        [self.ChatTableView reloadData];
//    }
    
//    [self.ChatTableView reloadData];
//    int lastRowNumber = [_ChatTableView numberOfRowsInSection:0] - 1;
//    NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
//    [_ChatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
- (void) setupAlertCtrl
{
    self.alertCtrl = [UIAlertController alertControllerWithTitle:@""
                                                         message:nil
                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    //Create an action
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self handleCamera];
                             }];
    UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"Library"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [self handleImageGallery];
                                   }];
    
   // UIAlertAction *imageGallery=[UIAlertAction actionWithTitle:@"Choose Existing" style:UIAlertActionStyleDefault handler:nil];
    
   /* UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }]; */
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    //Add action to alertCtrl
    [self.alertCtrl addAction:camera];
    [self.alertCtrl addAction:imageGallery];
    [self.alertCtrl addAction:cancel];
    
    
}

- (IBAction)selectImagePressed:(UIButton *)sender
{
    [self presentViewController:self.alertCtrl animated:YES completion:nil];
}

- (void)handleCamera
{
#if TARGET_IPHONE_SIMULATOR
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Camera is not available on simulator"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action)
                         {
                            // [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
#elif TARGET_OS_IPHONE
    //Some code for iPhone
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
#endif
}

- (void)handleImageGallery
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
   // self.imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:_imagePicker.sourceType];
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
    NSLog(@"Picker view ; %@",info);
    
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    //UIImage *img = [[UIImage alloc] initWithData:dataImage];
    PFFile *Img = [PFFile fileWithName:@"image.png" data:dataImage];
    PFObject *chat = [PFObject objectWithClassName:@"Chats"];
    chat[@"avatar"] = user[@"UserImage"];
    chat[@"image"] = Img;
    chat[@"useremail"]= user.email;
    [chat save];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Chats"];
    //[query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    NSArray* scoreArray = [query findObjects];
    NSLog(@"Chats are %@",scoreArray);
    
    PFFile *img = scoreArray[scoreArray.count-1][@"image"];
    PFFile *avatar = user[@"UserImage"];
    Firebase *postRef = [myRootRef childByAppendingPath: @"chat"];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    
    NSDictionary *post1 = @{
                            @"author": user.email,
                            @"message": img.url,
                            @"avatar": avatar.url
                            };
    Firebase *post1Ref = [postRef childByAutoId];
    [post1Ref setValue: post1];
        [self.UserArray addObject:user.email];
        [self.avatarArray addObject:avatar.url];
        [self.ChatArray addObject:img.url];
        [self.ChatTableView reloadData];
        int lastRowNumber = [ChatTableView numberOfRowsInSection:0] - 1;
        NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [ChatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //[self GettingDataFromFirebase];
        
    }else if ([mediaType isEqualToString:@"public.movie"]){
        
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSData *dataVid = [NSData dataWithContentsOfURL:videoURL];
        //UIImage *img = [[UIImage alloc] initWithData:dataImage];
        PFFile *Img = [PFFile fileWithName:@"image.mp4" data:dataVid];
        PFObject *chat = [PFObject objectWithClassName:@"Chats"];
        chat[@"avatar"] = user[@"UserImage"];
        chat[@"image"] = Img;
        chat[@"useremail"]= user.email;
        [chat save];
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"Chats"];
        //[query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
        NSArray* scoreArray = [query findObjects];
        NSLog(@"Chats are %@",scoreArray);
        
        PFFile *vid = scoreArray[scoreArray.count-1][@"image"];
        PFFile *avatar = user[@"UserImage"];
        Firebase *postRef = [myRootRef childByAppendingPath: @"chat"];
        NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
        
        NSDictionary *post1 = @{
                                @"author": user.email,
                                @"message": vid.url,
                                @"avatar": avatar.url
                                };
        Firebase *post1Ref = [postRef childByAutoId];
        [post1Ref setValue: post1];
        [self.UserArray addObject:user.email];
        [self.avatarArray addObject:avatar.url];
        [self.ChatArray addObject:vid.url];
        [self.ChatTableView reloadData];
        int lastRowNumber = [ChatTableView numberOfRowsInSection:0] - 1;
        NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [ChatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
        //[self GettingDataFromFirebase];
    }
    
   // [self.imageView setImage:img];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog( @"Count is :%lu",(unsigned long)self.ChatArray.count);
   return self.ChatArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"chat";
    ActivityTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (Cell == nil) {
       // Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        Cell = [[ActivityTableViewCell alloc]init];
    }
  
    
    
    if ([self.UserArray[indexPath.row] isEqualToString:user.email]) {

//        Cell.ChatLable.text = user.email;
//        Cell.meChatImge.image = [UIImage imageNamed:@"meeting.png"];
        Cell.FrndImg.image = [UIImage imageNamed:@""];
        Cell.FrndChatImge.image = [UIImage imageNamed:@""];
        PFFile *image = user[@"UserImage"];
        [Cell.MeImg sd_setImageWithURL:image.url];
//
//        Cell.MeImg.layer.cornerRadius = Cell.MeImg.frame.size.height/2;
//        Cell.MeImg.layer.borderWidth = 2;
//        Cell.MeImg.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor darkGrayColor]);
        
        NSURL *url = [NSURL URLWithString:self.ChatArray[indexPath.row]];
        if (url && url.scheme && url.host) {
            //Cell.ChatLable.hidden = YES;
            //Cell.meChatImge.hidden= NO;
           // NSURL *url = [NSURL URLWithString:_ChatArray[indexPath.row]];
            Cell.ChatLable.text = @"";
            [Cell.meChatImge sd_setImageWithURL:url];
            
        }else {
           // Cell.meChatImge.hidden = YES;
           // Cell.ChatLable.hidden= NO;
           // Cell.ChatLable.backgroundColor = [UIColor lightGrayColor];
            Cell.ChatLable.textAlignment = UITextAlignmentRight;
            Cell.meChatImge.image = [UIImage imageNamed:@""];
            Cell.ChatLable.text = _ChatArray[indexPath.row];
        }
        
//        Cell.backgroundColor = [UIColor clearColor];
//        Cell.textLabel.textAlignment = UITextAlignmentRight;
//        Cell.textLabel.text = self.ChatArray[indexPath.row];
//        Cell.textLabel.numberOfLines = 5;
//        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return Cell;
    }else{
        Cell.MeImg.image = [UIImage imageNamed:@""];
        Cell.meChatImge.image = [UIImage imageNamed:@""];
//        Cell.FrndImg.layer.cornerRadius = Cell.FrndImg.frame.size.height/2;
//        Cell.FrndImg.layer.borderWidth = 2;
//        Cell.FrndImg.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor darkGrayColor]);
        //PFFile *image = self.avatarArray[indexPath.row];
        [Cell.FrndImg sd_setImageWithURL:self.avatarArray[indexPath.row]];
        //Cell.FrndImg.image = [UIImage imageNamed:@"meeting.png"];
         NSURL *url = [NSURL URLWithString:self.ChatArray[indexPath.row]];
        if (url && url.scheme && url.host) {
            Cell.ChatLable.hidden = YES;
            Cell.FrndChatImge.hidden= NO;
            [Cell.FrndChatImge sd_setImageWithURL:url];
        }else {
            Cell.FrndChatImge.hidden = YES;
            Cell.ChatLable.hidden= NO;
            Cell.ChatLable.textAlignment = UITextAlignmentLeft;
            Cell.ChatLable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"meeting.png"]];
            Cell.ChatLable.text =_ChatArray[indexPath.row];
            Cell.ChatLable.sizeToFit;
        }
    
    return Cell;
    }
   // return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[Chattextfield resignFirstResponder];
    NSLog(@"Selected Row Is :%ld",(long)indexPath.row);
// Showning Image
    NSURL *url = [NSURL URLWithString:self.ChatArray[indexPath.row]];
    if (url && url.scheme && url.host) {
   
//       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//           
//       });
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.mediaFocusController showImageFromURL:url fromView:self.view];
            NSLog(@"in Main Queue");
        });
        UIImageView *img = [[UIImageView alloc]init];
        [img sd_setImageWithURL:url];
         [self.mediaFocusController showImage:img.image fromRect:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];

    }else{
        
    }
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self didBeginEditingIn:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //[self didEndEditing];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    //[Chattextfield resignFirstResponder];
    return YES;
}


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216+50;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162+100;

- (void)didBeginEditingIn:(UIView *)view
{
    
    CGRect textFieldRect = [self.view.window convertRect:view.bounds fromView:view];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5* textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        _animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        _animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.textchatView.frame;
    CGRect tableFrame = [self.ChatTableView frame];
    viewFrame.origin.y -= _animatedDistance;
    tableFrame.size.height -= _animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    //[self.view setFrame:viewFrame];
    [self.ChatTableView setFrame:tableFrame];
    [self.textchatView setFrame:viewFrame];
    
    
    [UIView commitAnimations];
    if (_ChatArray.count<=0) {
        
    }else{
    [self.ChatTableView reloadData];
    int lastRowNumber = [ChatTableView numberOfRowsInSection:0] - 1;
    NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
    [ChatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)didEndEditing
{
    CGRect viewFrame = [self.textchatView frame];
    CGRect tableFrame = [self.ChatTableView frame];
    
    viewFrame.origin.y += _animatedDistance;
    tableFrame.size.height += _animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.ChatTableView setFrame:tableFrame];
    [self.textchatView setFrame:viewFrame];
    
    
    [UIView commitAnimations];
    [self.ChatTableView reloadData];
    int lastRowNumber = [ChatTableView numberOfRowsInSection:0] - 1;
    NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
    [ChatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (IBAction)SendBtn:(id)sender {
    
    if ([Chattextfield.text isEqualToString:@""]) {
        [Chattextfield resignFirstResponder];
        
    }else{
        // Firebase
//        [self.ChatArray addObject:Chattextfield.text];
//        [self.UserArray addObject:@"me"];
        NSString *message = Chattextfield.text;
        
        Chattextfield.text =@"";
        //Firebase *ref = [[Firebase alloc] initWithUrl: @"https://synchronapp.firebaseio.com"];
        Firebase *postRef = [myRootRef childByAppendingPath: @"chat"];
        // NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
        PFFile *avatar = user[@"UserImage"];
        NSDictionary *post1 = @{
                                @"author": user.email,
                                @"message": message,
                                @"avatar":avatar.url
                                };
//        Firebase *post1Ref = [postRef childByAutoId];
//        [post1Ref setValue: post1];
        PFFile *img = user[@"UserImage"];
        [self.UserArray addObject:user.email];
        [self.avatarArray addObject:img.url];
        [self.ChatArray addObject:message];

       [self.ChatTableView reloadData];
        CGSize iOSScreenSize=[[UIScreen mainScreen]bounds].size;
        if (iOSScreenSize.height==736) {
            [Chattextfield resignFirstResponder];
        }
//        int lastRowNumber = [_ChatTableView numberOfRowsInSection:0] - 1;
//        NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
//        [_ChatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)UserLognInn {
  NSString*name =  [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
  NSString * email=  [[NSUserDefaults standardUserDefaults]objectForKey:@"UserEmail"];
    NSData *imagedata = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserImage"];
    PFFile *imageFile = [PFFile fileWithName:@"userImage.png" data:imagedata];
    PFUser *user = [PFUser user];
    user.username = email;
    user.password = @"@1234";
    user.email = email;
    user [@"UserImage"] = imageFile;
    
    // other fields can be set just like with PFObject
    //user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            NSLog(@"Sign UP Success %@",[PFUser currentUser]);
        } else {   NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            [PFUser logInWithUsernameInBackground:email password:@"@1234"
                                            block:^(PFUser *user, NSError *error) {
                                                if (user) {
                                                    // Do stuff after successful login.
                                                    NSLog(@"User Loginn is :%@",user);
                                                    PFFile *Image = user[@"UserImage"];
                                                    NSLog(@"image url %@ ",Image.url);
                                                } else {
                                                    // The login failed. Check error to see why.
                                                }
                                            }];

        }
    }];
    
}

-(void)getChatData{
   // PFUser *user = [PFUser currentUser];
    
    PFObject *chat = [PFObject objectWithClassName:@"Chats"];
    chat[@"avatar"] = user[@"UserImage"];
    chat[@"text"] = @"Thanks you ";
    chat[@"useremail"]= user.email;
    //[chat save];
    
    PFObject *chat1 = [PFObject objectWithClassName:@"Chats"];
    chat1[@"avatar"] = user[@"UserImage"];
    chat1[@"image"] = user[@"UserImage"];
    chat1[@"useremail"] = @"james";
    
    //[chat1 save];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Chats"];
    //[query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    NSArray* scoreArray = [query findObjects];
    NSLog(@"Chats are %@",scoreArray);
    PFFile *im = scoreArray[scoreArray.count-1][@"image"];
    
    NSURL *url = [NSURL URLWithString:im.url];
    if (url && url.scheme && url.host)
    {
        //the url looks ok, do something with it
        NSLog(@"%@ is a valid URL", im.url);
    }else{
        NSLog(@"not url In Scheema");
    }
   
    
//    [self.ChatArray addObject:Chattextfield.text];
//    [self.UserArray addObject:@"me"];
//    NSString *message = Chattextfield.text;
    
    
    //Firebase *ref = [[Firebase alloc] initWithUrl: @"https://synchronapp.firebaseio.com"];
    Firebase *postRef = [myRootRef childByAppendingPath: @"chat"];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    
    NSDictionary *post1 = @{
                            @"author": @"naveen@gamil.com",
                            @"message": @" How ryou Dong, this me your friend"
                            };
    Firebase *post1Ref = [postRef childByAutoId];
    //[post1Ref setValue: post1];
    
    
//    self.ChatArray = [NSMutableArray arrayWithArray:scoreArray];
//    [self.ChatTableView reloadData];
}

-(void)GettingDataFromFirebase{
    
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://synchronchatapp.firebaseio.com/chat"];
    //valueInExportFormat
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"snap shot %@",snapshot.valueInExportFormat);

        NSLog(@"%@", snapshot.value[@"author"]);
        NSLog(@"%@", snapshot.value[@"message"]);
        //NSLog(@"%@", snapshot.value[@"uid"]);
        
        if (snapshot.value[@"author"] !=NULL ) {
            
            if (self.UserArray== NULL) {
                self.UserArray = [[NSMutableArray alloc]init];
                self.ChatArray = [[NSMutableArray alloc]init];
                self.avatarArray=[[NSMutableArray alloc]init];
            }
            
            [self.UserArray addObject:snapshot.value[@"author"]];
            [self.ChatArray addObject:snapshot.value[@"message"]];
            [self.avatarArray addObject:snapshot.value[@"avatar"]];
            if (_UserArray.count==chatCount) {
                [self.ChatTableView reloadData];
                int lastRowNumber = [ChatTableView numberOfRowsInSection:0] - 1;
                NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
                [ChatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }else{
                NSLog(@"Chat count is:%d, and Array count is %lu",chatCount,self.ChatArray.count);
            }
            
            
            }
        
    }];
    
}

-(void)bobbleinit{
    NSBubbleData *heyBubble = [NSBubbleData dataWithText:@"Hey, halloween is soon" date:[NSDate dateWithTimeIntervalSinceNow:-300] type:BubbleTypeSomeoneElse];
    heyBubble.avatar = [UIImage imageNamed:@"profile.png"];
    
    NSBubbleData *photoBubble = [NSBubbleData dataWithImage:[UIImage imageNamed:@"003 Synchron_UEvents_attending_icon.png"] date:[NSDate dateWithTimeIntervalSinceNow:-290] type:BubbleTypeSomeoneElse];
    photoBubble.avatar = [UIImage imageNamed:@"profile.png"];
    
    NSBubbleData *replyBubble = [NSBubbleData dataWithText:@"Wow.. Really cool picture out there. iPhone 5 has really nice camera, yeah? || Wow.. Really cool picture out there. iPhone 5 has really nice camera, yeah?|| Wow.. Really cool picture out there. iPhone 5 has really nice camera, yeah?" date:[NSDate dateWithTimeIntervalSinceNow:-5] type:BubbleTypeMine];
    replyBubble.avatar = [UIImage imageNamed:@"meeting.png"];
    NSBubbleData *phot =[NSBubbleData dataWithImage:[UIImage imageNamed:@"meeting.png"] date:[NSDate dateWithTimeIntervalSinceNow:-1] type:BubbleTypeMine];
    
    bubbleData = [[NSMutableArray alloc] initWithObjects:heyBubble, photoBubble, replyBubble,phot, nil];
    ChatTableView.bubbleDataSource = self;
    
    // The line below sets the snap interval in seconds. This defines how the bubbles will be grouped in time.
    // Interval of 120 means that if the next messages comes in 2 minutes since the last message, it will be added into the same group.
    // Groups are delimited with header which contains date and time for the first message in the group.
    
    ChatTableView.snapInterval = 120;
    
    // The line below enables avatar support. Avatar can be specified for each bubble with .avatar property of NSBubbleData.
    // Avatars are enabled for the whole table at once. If particular NSBubbleData misses the avatar, a default placeholder will be set (missingAvatar.png)
    
    ChatTableView.showAvatars = YES;
    
    // Uncomment the line below to add "Now typing" bubble
    // Possible values are
    //    - NSBubbleTypingTypeSomebody - shows "now typing" bubble on the left
    //    - NSBubbleTypingTypeMe - shows "now typing" bubble on the right
    //    - NSBubbleTypingTypeNone - no "now typing" bubble
    
   // ChatTableView.typingBubble = NSBubbleTypingTypeSomebody;
    
    [ChatTableView reloadData];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [bubbleData count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleData objectAtIndex:row];
}

@end
