//
//  DKBarcodes.m
//  Constructor
//
//  Created by Aleksander Slater on 21/07/2016.
//  Copyright © 2016 IntroLabs. All rights reserved.
//

#import "DKBarcodes.h"

@implementation DKBarcodes

+ (UIImage*)createQRcode:(NSString*)text size:(CGFloat)size
{
    if (text==nil) return nil;
    
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

+ (NSString*)scanQRCode:(UIImage*)image
{
    if (image==nil) return nil;
    
    NSDictionary *optns = @{CIDetectorAccuracy:CIDetectorAccuracyHigh};
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:optns];
    CIImage *cimg = [[CIImage alloc] initWithImage:image];
    
    NSArray *features = [detector featuresInImage:cimg];
    for (CIQRCodeFeature *feature in features)
    {
        NSString *code = [feature messageString];
        return code;
    }
    return nil;
}

@end
