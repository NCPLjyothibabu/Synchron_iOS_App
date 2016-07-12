//
//  BusinessPartnersCollection.h
//  Synchron
//
//  Created by NCPL Inc on 27/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Advisors.h"
#import "AdCusCellCollectionViewCell.h"

@interface BusinessPartnersCollection : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *businessTableView;

@property (strong, nonatomic) NSMutableArray *BPartners;
@property (weak, nonatomic) IBOutlet UIButton *menu;

@end
