//
//  ActivityFeed.h
//  Synchron
//
//  Created by NCPL Inc on 28/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"

@interface ActivityFeed : UIViewController<UIBubbleTableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIButton *menu;

@property (strong, nonatomic) IBOutlet UITextField *Chattextfield;
@property (weak, nonatomic) IBOutlet UIBubbleTableView *ChatTableView;


@end