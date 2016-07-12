//
//  WebViewController.m
//  Synchron
//
//  Created by NCPL Inc on 28/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "WebViewController.h"
#import "SWRevealViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface WebViewController ()

@end

@implementation WebViewController
@synthesize sidebarButton;
- (void)viewDidLoad {
    [super viewDidLoad];
     [self.menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    /*
    UIWebView *webView = [[UIWebView alloc]init];
    NSString *urlString = @"http://www.apple.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    [self.view addSubview:webView]; */
    
//    SWRevealViewController *revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
//        [self.sidebarButton setTarget: self.revealViewController];
//        [self.sidebarButton setAction: @selector( revealToggle: )];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
/*
    NSString *urlString = @"www.google.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest]; */
    // Do any additional setup after loading the view.
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.synchrongroup.com.au"]];
    [self.webView loadRequest:request];
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
 */- (IBAction)loadurlAction:(id)sender
{
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]];
    [self.webView loadRequest:request];
}

- (IBAction)loadHtmlAction:(id)sender
{
    
   // NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
  //  NSLog(@"%@",url);
   // [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]];
    [self.webView loadRequest:request];
}

- (IBAction)loadDataAction:(id)sender
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sampleWord" withExtension:@"docx"];
    NSLog(@"%@",url);
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

#pragma - mark UIWebView Delegate Methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Loading URL :%@",request.URL.absoluteString);
    
    //return FALSE; //to stop loading
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Failed to load with error :%@",[error debugDescription]);
    
}

//-(void)showSynchronLocation{
//    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
//    
//    point.title =@"Synchron Office";
//    point.subtitle=@"65 Palmerston Cres, South Melbourne VIC 3205, Australia";
//     CLLocation *cl = [[CLLocation alloc]initWithLatitude:-37.834897 longitude:144.969298];
//    point.coordinate = CLLocationCoordinate2DMake(cl.coordinate.latitude, cl.coordinate.longitude);
//    [mapView addAnnotation:point];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(point.coordinate, 2003, 2003);
//    [self.mapView setRegion:region animated:YES];
//}


@end
