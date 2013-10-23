//
//  DKBarcodeScanViewController.h
//  Constructor
//
//  Created by Aleksander Slater on 11/10/2013.
//  Copyright (c) 2013 IntroLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class DKBarcodeScanViewController;
@protocol DKBarcodeScanDelegate <NSObject>
- (void)barcodeScanner:(DKBarcodeScanViewController*)scanner scannedCode:(NSString*)code;
@end

@interface DKBarcodeScanViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *previewLayer;
}
@property(nonatomic,assign) id<DKBarcodeScanDelegate> delegate;
@property(nonatomic,strong) UIView *cameraPreview;
- (id)initWithDelegate:(id<DKBarcodeScanDelegate>)delegate;
- (void)displayWarning:(NSString*)warning;
+ (BOOL)canScan;
@end
