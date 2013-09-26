//
//  UIColor+DavKit.m
//  Constructor
//
//  Created by Aleksander Slater on 26/09/2013.
//  Copyright (c) 2013 IntroLabs. All rights reserved.
//

#import "UIColor+DavKit.h"

@implementation UIColor (DavKit)

+ (UIColor*)colorFromIntegersRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    CGFloat redF = red/255.0;
    CGFloat greenF = green/255.0;
    CGFloat blueF = blue/255.0;
    return [UIColor colorWithRed:redF green:greenF blue:blueF alpha:alpha];
}

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
    unsigned int hexInt;
    if (![[NSScanner scannerWithString:hexString] scanHexInt:&hexInt])
        return nil;
    return [UIColor colorFromHexRGBA:hexInt];
}

+ (UIColor*)colorFromHexRGBString:(NSString*)hexString
{
    unsigned int hexInt;
    if (![[NSScanner scannerWithString:hexString] scanHexInt:&hexInt])
        return nil;
    return [UIColor colorFromHexRGB:hexInt];
}

@end
