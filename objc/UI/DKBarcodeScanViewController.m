//
//  DKBarcodeScanViewController.m
//  DavKit
//
//  Created by Aleksander Slater on 11/10/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "DKBarcodeScanViewController.h"
#import "UIAlertView+DavKit.h"
#import "DKUtils.h"

#define kScanBlock "com.davincium.dkbarcodescannerblock"

@interface DKBarcodeScanViewController ()

@end

@implementation DKBarcodeScanViewController

+ (BOOL)canScan
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7)
        return YES;
    return NO;
}

- (id)initWithDelegate:(id<DKBarcodeScanDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
    }
    return self;
}

- (id)initWithBlock:(void (^)(DKBarcodeScanViewController*scanner,NSString *code))aBlock
{
    self = [super init];
    if (self)
    {
        [DKUtils setBlock:aBlock withKey:kScanBlock forObject:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Scan QR Code";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(clickedCancel:)];
    
    self.cameraPreview = [[UIView alloc] initWithFrame:self.view.bounds];
    self.cameraPreview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.cameraPreview];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupScanSession];
    
    [self updateInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation] animated:NO duration:0];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setdownScanSession];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)clickedCancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)updateInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation animated:(BOOL)animated duration:(NSTimeInterval)duration
{
    CGFloat rotation = 0;
    switch (interfaceOrientation)
    {
        case UIInterfaceOrientationPortrait: rotation = 0; break;
        case UIInterfaceOrientationPortraitUpsideDown: rotation = M_PI; break;
        case UIInterfaceOrientationLandscapeLeft: rotation = M_PI/2; break;
        case UIInterfaceOrientationLandscapeRight: rotation = -M_PI/2; break;
        case UIInterfaceOrientationUnknown: rotation = 0; break;
    }

    if (animated)
    {
        [UIView beginAnimations:@"Update interface orientation" context:nil];
        [UIView setAnimationDuration:duration];
    }
    self.cameraPreview.transform = CGAffineTransformMakeRotation(rotation);
    if (animated)
    {
        [UIView commitAnimations];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self updateInterfaceOrientation:toInterfaceOrientation animated:YES duration:duration];
}

#pragma mark - Scanning

- (BOOL)setupScanSession
{
    isClosing = NO;
    
    session = [[AVCaptureSession alloc]init];
    
    NSError *error = nil;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (input == nil)
    {
        NSString *title = @"Failed to start scanner";
        NSString *msg = [error localizedDescription];
        NSLog(@"Error: %@",msg);
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:title message:msg completionBlock:
        ^(NSUInteger buttonIndex,UIAlertView*alertView)
        {
            [self clickedCancel:nil];
        }
        cancelButtonTitle:@"Understood" otherButtonTitles:nil];
        [al show];
        return NO;
    }
    else
        [session addInput:input];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode]];
    
    previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewLayer.frame = self.view.bounds;
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.cameraPreview.layer addSublayer:previewLayer];
    
    [session startRunning];
    return YES;
}

- (void)setdownScanSession
{
    if (session!=nil)
        [session stopRunning];
    session = nil;
    if (previewLayer!=nil)
        [previewLayer removeFromSuperlayer];
    previewLayer = nil;
}

- (void)terminate
{
    [self setdownScanSession];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *code = nil;
    
    for (AVMetadataMachineReadableCodeObject* metadata in metadataObjects)
    {
        code = [metadata stringValue];
    }
    
    if (!isClosing && self.delegate!=nil)
    {
        if (self.delegate!=nil)
        {
            [self.delegate barcodeScanner:self scannedCode:code];
        }
        else
        {
            void (^block)(DKBarcodeScanViewController*scanner,NSString *code) = [DKUtils getBlockForObject:self withKey:kScanBlock];
            if (block!=NULL)
            {
                block(self,code);
            }
        }
    }
}

- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion
{
    isClosing = YES;
    [super dismissViewControllerAnimated:flag completion:completion];
}

@end

@implementation DKBarcodes

+ (UIImage*)createQRcode:(NSString*)text size:(CGFloat)size
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setDefaults];
    
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *input = [filter outputImage];
    
    CGFloat scale = 1;
    CGFloat h = [input extent].size.height;
    if (h < size)
    {
        scale = size / h;
    }
    
    CGAffineTransform transform = CGAffineTransformMakeScale(scale,scale);
    
    CIImage *outputImage = [input imageByApplyingTransform: transform];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGRect fromRect = [outputImage extent];
    
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:fromRect];
    
    UIImage *img = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return img;
}

@end
