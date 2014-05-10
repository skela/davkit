//
//  UIText+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 03/03/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITextHelper : NSObject

+ (NSMutableAttributedString*)attributedStringForText:(NSString*)str withSubString:(NSString*)subString withAttributes:(NSDictionary*)attr;
+ (NSDictionary*)attributesWithColor:(UIColor*)subStringColor andFont:(UIFont*)subStringFont;
+ (NSDictionary*)attributesWithColor:(UIColor*)subStringColor;
+ (NSDictionary*)attributesWithFont:(UIFont*)subStringFont;

@end

@interface UILabel (DavKit)

- (void)setText:(NSString*)str withSubString:(NSString*)subString withAttributes:(NSDictionary*)attr;
- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor andFont:(UIFont*)subStringFont;
- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor;
- (void)setText:(NSString*)str withSubString:(NSString*)subString inFont:(UIFont*)subStringFont;
- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString;
- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString andColor:(UIColor*)subStringColor;

@end

@interface UITextView (DavKit)

- (void)setText:(NSString*)str withSubString:(NSString*)subString withAttributes:(NSDictionary*)attr;
- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor andFont:(UIFont*)subStringFont;
- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor;
- (void)setText:(NSString*)str withSubString:(NSString*)subString inFont:(UIFont*)subStringFont;
- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString;
- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString andColor:(UIColor*)subStringColor;

@end

@interface UITextField (DavKit)

- (void)setText:(NSString*)str withSubString:(NSString*)subString withAttributes:(NSDictionary*)attr;
- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor andFont:(UIFont*)subStringFont;
- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor;
- (void)setText:(NSString*)str withSubString:(NSString*)subString inFont:(UIFont*)subStringFont;
- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString;
- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString andColor:(UIColor*)subStringColor;

@end
