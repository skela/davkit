//
//  NSString+DavKit.m
//  Constructor
//
//  Created by Aleksander Slater on 13/09/2013.
//  Copyright (c) 2013 IntroLabs. All rights reserved.
//

#import "NSString+DavKit.h"

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

@end
