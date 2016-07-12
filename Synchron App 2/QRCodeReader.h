//
//  QRCodeReader.h
//  Synchron
//
//  Created by NCPL Inc on 30/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface QRCodeReader : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *barCodeNum;
@property (weak, nonatomic) IBOutlet UIButton *startScan;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *startScan;

- (IBAction)startCodes:(id)sender;

@end
