//
//  WebViewController.h
//  Synchron
//
//  Created by NCPL Inc on 28/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
//@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)loadurlAction:(id)sender;
- (IBAction)loadHtmlAction:(id)sender;
- (IBAction)loadDataAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *menu;


@end
