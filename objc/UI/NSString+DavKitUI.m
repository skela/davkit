//
//  NSString+DavKitUI.m
//  Constructor
//
//  Created by Aleksander Slater on 29/08/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import "NSString+DavKitUI.h"
#import "UIText+DavKit.h"

@implementation NSString (DavKitUI)

- (CGSize)sizeUsingFont:(UIFont *)font
{
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary* attribs = @{NSFontAttributeName:font};
        return ([self sizeWithAttributes:attribs]);
    }
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return ([self sizeWithFont:font]);
#pragma GCC diagnostic pop
}

- (CGSize)sizeUsingFont:(UIFont*)font constrainedToSize:(CGSize)constraint lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize size;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        
        CGSize boundingBox = [self boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else
    {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:font constrainedToSize:constraint lineBreakMode:lineBreakMode];
#pragma GCC diagnostic pop
    }
    
    return size;
}

- (NSAttributedString*)bold:(NSString*)subString
{
    return [self bold:subString size:12];
}

- (NSAttributedString*)bold:(NSString*)subString size:(CGFloat)size
{
    return [UITextHelper attributedStringForText:self withSubString:subString withAttributes:[UITextHelper attributesWithFont:[UIFont boldSystemFontOfSize:size]]];
}

- (NSAttributedString*)strikethrough:(NSString*)subString
{
    return [UITextHelper attributedStringForText:self withSubString:subString withAttributes:[UITextHelper attributesWithStrikethrough]];
}

@end
