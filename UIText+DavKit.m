//
//  UIText+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 03/03/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "UIText+DavKit.h"

#define CAN_ATTR [[UIDevice currentDevice].systemVersion floatValue]>=6.0

@implementation UITextHelper

+ (NSMutableAttributedString*)attributedStringForText:(NSString*)str withSubString:(NSString*)subString withAttributes:(NSDictionary*)attr
{
    if (subString==nil || str==nil || attr==nil)  return nil;
    
    NSRange subRange = [str rangeOfString:subString];
    if (subRange.location!=NSNotFound)
    {
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc] initWithString:str];
        [mstr setAttributes:attr range:subRange];
        return mstr;
    }
    
    return nil;
}

+ (NSDictionary*)attributesWithColor:(UIColor*)subStringColor andFont:(UIFont*)subStringFont
{
    if (CAN_ATTR)
        return @{NSForegroundColorAttributeName:subStringColor,NSFontAttributeName:subStringFont};
    return nil;
}

+ (NSDictionary*)attributesWithColor:(UIColor*)subStringColor
{
    if (CAN_ATTR)
        return @{NSForegroundColorAttributeName:subStringColor};
    return nil;
}


+ (NSDictionary*)attributesWithFont:(UIFont*)subStringFont
{
    if (CAN_ATTR)
        return @{NSFontAttributeName:subStringFont};
    return nil;
}

@end

@implementation UILabel (DavKit)

- (void)setText:(NSString*)str withSubString:(NSString*)subString withAttributes:(NSDictionary*)attr
{
    NSMutableAttributedString *atrs = [UITextHelper attributedStringForText:str withSubString:subString withAttributes:attr];
    if (atrs!=nil) [self setAttributedText:atrs]; else [self setText:str];
}

- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor andFont:(UIFont*)subStringFont
{
    [self setText:str withSubString:subString withAttributes:[UITextHelper attributesWithColor:subStringColor andFont:subStringFont]];
}

- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor
{
    [self setText:str withSubString:subString withAttributes:[UITextHelper attributesWithColor:subStringColor]];
}

- (void)setText:(NSString*)str withSubString:(NSString*)subString inFont:(UIFont*)subStringFont
{
    [self setText:str withSubString:subString withAttributes:[UITextHelper attributesWithFont:subStringFont]];
}

- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString
{
    [self setText:str withSubString:subString inFont:[UIFont boldSystemFontOfSize:self.font.pointSize]];
}

- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString andColor:(UIColor*)subStringColor
{
    [self setText:str withSubString:subString inColor:subStringColor andFont:[UIFont boldSystemFontOfSize:self.font.pointSize]];
}

@end

@implementation UITextView (DavKit)

- (void)setText:(NSString*)str withSubString:(NSString*)subString withAttributes:(NSDictionary*)attr
{
    NSMutableAttributedString *atrs = [UITextHelper attributedStringForText:str withSubString:subString withAttributes:attr];
    if (atrs!=nil) [self setAttributedText:atrs]; else [self setText:str];
}

- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor andFont:(UIFont*)subStringFont
{
    [self setText:str withSubString:subString withAttributes:[UITextHelper attributesWithColor:subStringColor andFont:subStringFont]];
}

- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor
{
    [self setText:str withSubString:subString withAttributes:[UITextHelper attributesWithColor:subStringColor]];
}

- (void)setText:(NSString*)str withSubString:(NSString*)subString inFont:(UIFont*)subStringFont
{
    [self setText:str withSubString:subString withAttributes:[UITextHelper attributesWithFont:subStringFont]];
}

- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString
{
    [self setText:str withSubString:subString inFont:[UIFont boldSystemFontOfSize:self.font.pointSize]];
}

- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString andColor:(UIColor*)subStringColor
{
    [self setText:str withSubString:subString inColor:subStringColor andFont:[UIFont boldSystemFontOfSize:self.font.pointSize]];
}

@end

@implementation UITextField (DavKit)

- (void)setText:(NSString*)str withSubString:(NSString*)subString withAttributes:(NSDictionary*)attr
{
    NSMutableAttributedString *atrs = [UITextHelper attributedStringForText:str withSubString:subString withAttributes:attr];
    if (atrs!=nil) [self setAttributedText:atrs]; else [self setText:str];
}

- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor andFont:(UIFont*)subStringFont
{
    [self setText:str withSubString:subString withAttributes:[UITextHelper attributesWithColor:subStringColor andFont:subStringFont]];
}

- (void)setText:(NSString*)str withSubString:(NSString*)subString inColor:(UIColor*)subStringColor
{
    [self setText:str withSubString:subString withAttributes:[UITextHelper attributesWithColor:subStringColor]];
}

- (void)setText:(NSString*)str withSubString:(NSString*)subString inFont:(UIFont*)subStringFont
{
    [self setText:str withSubString:subString withAttributes:[UITextHelper attributesWithFont:subStringFont]];
}

- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString
{
    [self setText:str withSubString:subString inFont:[UIFont boldSystemFontOfSize:self.font.pointSize]];
}

- (void)setText:(NSString*)str withSubStringInBold:(NSString*)subString andColor:(UIColor*)subStringColor
{
    [self setText:str withSubString:subString inColor:subStringColor andFont:[UIFont boldSystemFontOfSize:self.font.pointSize]];
}

@end

