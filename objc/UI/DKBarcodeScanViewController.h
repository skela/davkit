//
//  DKBarcodeScanViewController.h
//  DavKit
//
//  Created by Aleksander Slater on 11/10/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class DKBarcodeScanViewController;
@protocol DKBarcodeScanDelegate <NSObject>
- (void)barcodeScanner:(DKBarcodeScanViewController*)scanner scannedCode:(NSString*)code;
@end

@class DKBarcodeScanViewController;
typedef BOOL(^DKBarcodeScannerBlock)(DKBarcodeScanViewController*scanner,NSString *code);

@interface DKBarcodeScanViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *previewLayer;
    BOOL isClosing;
}
@property(nonatomic,assign) id<DKBarcodeScanDelegate> delegate;
@property(nonatomic,strong) UIView *cameraPreview;
- (id)initWithDelegate:(id<DKBarcodeScanDelegate>)delegate;
- (id)initWithBlock:(DKBarcodeScannerBlock)aBlock;
- (void)terminate;
+ (BOOL)canScan;
@end
