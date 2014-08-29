//
//  UIColor+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 26/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DavKit)

+ (UIColor*)colorFromIntegersRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (UIColor*)colorFromHexRGBA:(uint32_t)hex;
+ (UIColor*)colorFromHexRGB:(uint32_t)hex;
+ (UIColor*)colorFromHexRGBOrRGBAString:(NSString*)hexString;
+ (UIColor*)colorFromHexRGBAString:(NSString*)hexString;
+ (UIColor*)colorFromHexRGBString:(NSString*)hexString;

- (NSString*)hexRGBString;
- (NSString*)hexRGBAString;

- (CGFloat) red;
- (CGFloat) green;
- (CGFloat) blue;
- (CGFloat) alpha;;

- (UIColor*)inverseColor;
- (UIColor *)darken;
- (UIColor *)darkenWithFactor:(CGFloat)amount;

@end
