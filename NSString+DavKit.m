//
//  NSString+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 13/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "NSString+DavKit.h"
#import "UIText+DavKit.h"

@implementation NSString (DavKit)

- (BOOL)contains:(NSString*)subString
{
    NSRange r = [self rangeOfString:subString];
    if (r.location!=NSNotFound)
        return YES;
    return NO;
}

- (NSUInteger)numberOfOccurrences:(NSString*)subString
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:subString options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0,[self length])];
    return numberOfMatches;
}

- (BOOL)containsPattern:(NSString*)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0,[self length])];
    return numberOfMatches>0;
}

- (NSString *)extractStringLookingFor:(NSString *)lookFor skipForwardTo:(NSInteger)skipForward andStopBefore:(NSString *)stopBefore
{
    NSRange firstRange = [self rangeOfString:lookFor];
    if (firstRange.location == NSNotFound)
        return nil;
    NSRange secondRange = [[self substringFromIndex:firstRange.location + skipForward] rangeOfString:stopBefore];
    if (secondRange.location == NSNotFound)
        return nil;
    NSRange finalRange = NSMakeRange(firstRange.location + skipForward, secondRange.location + [stopBefore length]-1);
    return [self substringWithRange:finalRange];
}

- (NSString *)extractStringLookingFor:(NSString *)lookFor andStopBefore:(NSString *)stopBefore
{
    return [self extractStringLookingFor:lookFor skipForwardTo:lookFor.length andStopBefore:stopBefore];
}

- (NSData*)stringToBase64EncodedData
{
    NSData *data;
    
    if ([data respondsToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        data = [[NSData alloc] initWithBase64EncodedString:self options:kNilOptions];  // iOS 7+
    }
    else
    {
        data = [[NSData alloc] initWithBase64Encoding:self];                           // pre iOS7
    }
    return data;
}

- (NSURL*)URL
{
    NSURL *retUrl = nil;
    if (self.length>0)
    {
        @try { retUrl = [NSURL URLWithString:self]; } @catch(NSException *er) { }
        if (retUrl==nil || [retUrl scheme]==nil)
        {
            NSRange r = [self rangeOfString:@"://"];
            if (r.location==NSNotFound)
            {
                NSString *str = [NSString stringWithFormat:@"http://%@",self];
                @try { retUrl = [NSURL URLWithString:str]; } @catch(NSException *er) { }
            }
        }
    }
    return retUrl;
}

- (NSString*)dotFilePath
{
    NSString *lp = [self lastPathComponent];
    NSString *r = [self stringByDeletingLastPathComponent];
    if ([lp hasPrefix:@"."])
        return self;
    NSString *res = [NSString stringWithFormat:@".%@",lp];
    return [r stringByAppendingPathComponent:res];
}

#define REGEX_FOR_NUMBERS   @"^([+-]?)(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
#define REGEX_FOR_INTEGERS  @"^([+-]?)(?:|0|[1-9]\\d*)?$"

- (BOOL)isInteger
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_FOR_INTEGERS] evaluateWithObject:self];
}

- (BOOL)isNumber
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_FOR_NUMBERS] evaluateWithObject:self];
}

- (CGSize)sizeUsingFont:(UIFont *)font
{
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary* attribs = @{NSFontAttributeName:font};
        return ([self sizeWithAttributes:attribs]);
    }
    return ([self sizeWithFont:font]);
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
        size = [self sizeWithFont:font constrainedToSize:constraint lineBreakMode:lineBreakMode];
    }
    
    return size;
}

- (NSString*)strip
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

- (NSString*)first
{
    if ([self length]>0)
    {
        NSRange r; r.location=0; r.length=1;
        return [self substringWithRange:r];
    }
    return nil;
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
