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

@end
