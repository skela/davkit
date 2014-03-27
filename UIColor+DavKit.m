//
//  UIColor+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 26/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "UIColor+DavKit.h"

@implementation UIColor (DavKit)

#pragma mark - Convenience

+ (UIColor*)colorFromIntegersRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    CGFloat redF = red/255.0;
    CGFloat greenF = green/255.0;
    CGFloat blueF = blue/255.0;
    return [UIColor colorWithRed:redF green:greenF blue:blueF alpha:alpha];
}

#pragma mark - Hex

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF000000) >> 24))/255.0 green:((float)((rgbValue & 0xFF0000) >> 16))/255.0 blue:((float)((rgbValue & 0xFF00) >> 8))/255.0 alpha:((float)(rgbValue & 0xFF))/255.0]

+ (UIColor*)colorFromHexRGBA:(uint32_t)hex
{
    UIColor* col = UIColorFromRGBA(hex);
    return col;
}

+ (UIColor*)colorFromHexRGB:(uint32_t)hex
{
    UIColor* col = UIColorFromRGB(hex);
    return col;
}

+ (UIColor*)colorFromHexRGBAString:(NSString*)hexString
{
    NSString *safeHexString = hexString;
    if ([hexString hasPrefix:@"#"])
        safeHexString = [hexString substringFromIndex:1];
    unsigned int hexInt;
    if (![[NSScanner scannerWithString:safeHexString] scanHexInt:&hexInt])
        return nil;
    return [UIColor colorFromHexRGBA:hexInt];
}

+ (UIColor*)colorFromHexRGBString:(NSString*)hexString
{
    NSString *safeHexString = hexString;
    if ([hexString hasPrefix:@"#"])
        safeHexString = [hexString substringFromIndex:1];
    unsigned int hexInt;
    if (![[NSScanner scannerWithString:safeHexString] scanHexInt:&hexInt])
        return nil;
    return [UIColor colorFromHexRGB:hexInt];
}

- (NSString*)hexRGBString
{
    CGFloat r = [self red];
    CGFloat g = [self green];
    CGFloat b = [self blue];
    int ri = (int)(r*255);
    int gi = (int)(g*255);
    int bi = (int)(b*255);
    return [NSString stringWithFormat:@"#%02x%02x%02x",ri,gi,bi];
}

- (NSString*)hexRGBAString
{
    CGFloat r = [self red];
    CGFloat g = [self green];
    CGFloat b = [self blue];
    CGFloat a = [self alpha];
    int ri = (int)(r*255);
    int gi = (int)(g*255);
    int bi = (int)(b*255);
    int ai = (int)(a*255);
    return [NSString stringWithFormat:@"#%02x%02x%02x%02x",ri,gi,bi,ai];
}

#pragma mark - Channels

- (CGColorSpaceModel) colorSpaceModel
{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (NSString *) colorSpaceString
{
    switch ([self colorSpaceModel])
    {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (BOOL) canProvideRGBComponents
{
    return (([self colorSpaceModel] == kCGColorSpaceModelRGB) ||
            ([self colorSpaceModel] == kCGColorSpaceModelMonochrome));
}

- (CGFloat) red
{
    if (![self canProvideRGBComponents])
    {
        NSLog(@"Must be a rgb color to get RGB components");
        return 0;
    }
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat) green
{
    if (![self canProvideRGBComponents])
    {
        NSLog(@"Must be a rgb color to get RGB components");
        return 0;
    }
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat) blue
{
    if (![self canProvideRGBComponents])
    {
        NSLog(@"Must be a rgb color to get RGB components");
        return 0;
    }
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat) alpha
{
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[CGColorGetNumberOfComponents(self.CGColor)-1];
}

- (UIColor*)inverseColor
{
    CGFloat r,g,b,a;
    
    [self getRed:&r green:&g blue:&b alpha:&a];
    
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome)
        a = 1;
    
    if (r>1) r=1;
    if (g>1) g=1;
    if (b>1) b=1;
    
    r = 1.0f-r;
    g = 1.0f-g;
    b = 1.0f-b;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

- (UIColor *)darken
{
    return [self darkenWithFactor:0.75];
}

- (UIColor *)darkenWithFactor:(CGFloat)amount
{
    CGFloat h,s,b,a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
    {
        if (b>0.4)
            b = b*0.75;
        if (a<=0.5)
            a = 0.5+a * (2*amount);
        //NSLog(@"Color with h:%g s:%g b:%g a:%g",h,s,b,a);
        return [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
    }
    return self;
}

@end
