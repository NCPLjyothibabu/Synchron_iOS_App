//
//  AdvisorCollection.m
//  Synchron
//
//  Created by NCPL Inc on 23/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "AdvisorCollection.h"
#import "AdvisorCell.h"
//#import "NZCircularImageView.h"
#import "SWRevealViewController.h"

@interface AdvisorCollection ()
@property UIActivityIndicatorView *spinner;
@property (strong, atomic) NSMutableArray *partnersData;
@property (strong, atomic) NSMutableArray *TeamData;
@property (strong, atomic) NSString * CellId;
@end



BOOL partners;
@implementation AdvisorCollection
@synthesize spinner, advisorTableView,partnersData,TeamData,CellId;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CellId = @"cell";
    [self.menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //partners =YES;
    partnersData = [[NSMutableArray alloc]init];
    [self performSelectorInBackground:@selector(loaddata) withObject:nil];
   
    //[self loaddata];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    
    [spinner startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return partnersData.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Iden = @"cell";
    AdvisorCell *cell = [tableView dequeueReusableCellWithIdentifier:Iden];
    
    if (cell == nil) {
        cell = [[AdvisorCell alloc]init];
    }
    cell.AdvisorImage.layer.cornerRadius = cell.AdvisorImage.frame.size.height/2;
    cell.AdvisorImage.clipsToBounds = YES;
    cell.AdvisorImage.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
    cell.AdvisorImage.layer.borderWidth= 2.0f;
    NSLog(@"Date go is :%@", partnersData[indexPath.row]);
        if (![[partnersData [indexPath.row] valueForKey:@" Advisor Image"] isEqualToString:@"Null"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
           NSString *image = [NSString stringWithFormat:@"%@",[partnersData[indexPath.row] valueForKey:@" Advisor Image"]];
            NSData *imagdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
//                if(imagdata ==nil){
//                    cell.AdvisorImage.image = [UIImage imageNamed:@"profile.png"];
//                }else{
                //UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
                cell.AdvisorImage.image = [UIImage imageWithData:imagdata];
            //}
           });
        });
        }else{
            cell.AdvisorImage.image = [UIImage imageNamed:@"profile.png"];
        }
    
    
    
        cell.AdvisorName.text = [NSString stringWithFormat:@"%@ %@",[partnersData[indexPath.row] valueForKey:@"FirstName"],[partnersData[indexPath.row] valueForKey:@"LastName"]];
    cell.advisorPosition.text = [NSString stringWithFormat:@"%@",[partnersData[indexPath.row] valueForKey:@"User Position"]];
    
//    cell.AdvisorName.text= @"Testing ";
//    cell.advisorPosition.text =@"Major";
    
        return cell;
   
}


-(void)setdata:(NSInteger*)index{
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Advisors * ad =[self.storyboard instantiateViewControllerWithIdentifier:@"AdvisorDetails"];
    
        [ad setData:partnersData[indexPath.row]];
    
    [self.navigationController presentViewController:ad animated:YES completion:nil];
}

-(void)loaddata{
   
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/alladvisors.php"]];
    NSURLRequest *prequest = [NSURLRequest requestWithURL:url];
    NSData *pdata = [[NSData alloc]init];
    partnersData = [[NSMutableArray alloc]init];
    pdata = [NSURLConnection sendSynchronousRequest:prequest returningResponse:nil error:nil];
    partnersData = [NSJSONSerialization JSONObjectWithData:pdata options:kNilOptions error:nil];
    NSLog(@" Partnerts Are : %lu",(unsigned long)partnersData.count);
    
    
//    NSURL *turl = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/alladvisors.php"]];
//    NSURLRequest *trequest = [NSURLRequest requestWithURL:turl];
//    NSData *tdata = [[NSData alloc]init];
//    TeamData = [[NSMutableArray alloc]init];
//    tdata = [NSURLConnection sendSynchronousRequest:trequest returningResponse:nil error:nil];
//    TeamData = [NSJSONSerialization JSONObjectWithData:tdata options:kNilOptions error:nil];
//    NSLog(@"Synchron Team :%lu",(unsigned long)TeamData.count);
    
    [advisorTableView reloadData];
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



@end
