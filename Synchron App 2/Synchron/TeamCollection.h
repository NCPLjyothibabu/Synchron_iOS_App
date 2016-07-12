//
//  TeamCollection.h
//  Synchron
//
//  Created by NCPL Inc on 27/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Advisors.h"
#import "AdCusCellCollectionViewCell.h"
#import "SWRevealViewController.h"

@interface TeamCollection : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *teamTableView;


@property (weak, nonatomic) IBOutlet UIButton *menu;

@property (strong, nonatomic) NSMutableArray * BPartners;
@end
