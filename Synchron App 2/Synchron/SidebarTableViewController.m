//
//  SidebarTableViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
//#import "PhotoViewController.h"
#import "PhotoViewController.h"
#import "UsermenuTableViewCell.h"

@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController {
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
  //  menuItems = @[@"title", @"news", @"comments", @"map", @"calendar", @"wishlist", @"bookmark", @"tag"];
   // UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu_menu bg.png"]];
  //  [tempImageView setFrame:self.tableView.frame];
    
   // self.tableView.backgroundView = tempImageView;
   // [self.view setBackgroundColor:[UIImage imageNamed:@"Menu_menu bg.png"]];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"004 Synchron_Menu_menu bg.png"]];
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    menuItems=@[@"title",@"MyProfile",@"Advisors",@"Activity Feed",@"BusinessPartners",@"TeamMembers",@"Events",@"MarkAttendance",@"Logout",@"webLocation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section./srikanth/srikanth/Ncpl Projects/WireFrames Synchrony/Synchron /Synchron UI Screen Elements/004 Synchron Menu Elements/004 Synchron_Menu_menu bg.png
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // NSInteger feedIndex = [indexPath indexAtPosition:[indexPath length] - 1];
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    static NSString *cell1 = @"Title";
    if (indexPath.row == 0)
    {
        UsermenuTableViewCell *cell = (UsermenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell1];
        if (cell == nil) {
            cell = [[UsermenuTableViewCell alloc]initWithFrame:CGRectZero reuseIdentifier:cell1];
           
           // [[[cell subviews] objectAtIndex:0] setTag:111];
            
        }
         NSString *username = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userFullName"]];
        NSLog(@" in Menu: %@",username);
        NSString *userPosition = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"UserPosition"]];
        NSString *userAddress = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"UserAddress"]];
      NSLog(@" in Menu: %@, %@, %@",username,userPosition,userAddress);
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"] !=NULL) {
            cell.userImage.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"]];
        }else{
            cell.userImage.image = [UIImage imageNamed:@"profile.png"];
        }
        cell.userName.text = username;
        cell.userPosition.text = userPosition;
        cell.userAddress.text = userAddress;
        
    
        
        cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width/2;
        cell.userImage.clipsToBounds = YES;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [[[cell subviews] objectAtIndex:0] setTag:111];
    
    return cell;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    else if(indexPath.row == menuItems.count-1){
        return 70;
    }else{
        return 50;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 /*
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"showPhoto"]) {
        UINavigationController *navController = segue.destinationViewController;
        PhotoViewController *photoController = [navController childViewControllers].firstObject;
        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo", [menuItems objectAtIndex:indexPath.row]];
        photoController.photoFilename = photoFilename;
    } */
}


@end
