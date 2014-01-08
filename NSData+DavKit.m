//
//  NSData+DavKit.m
//  Constructor
//
//  Created by Aleksander Slater on 08/01/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import "NSData+DavKit.h"

@implementation NSData (DavKit)

- (NSString*)encodedBase64String
{
    NSString *string;
    
    if ([self respondsToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        string = [self base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    }
    else
    {
        string = [self base64Encoding];                              // pre iOS7
    }
    return string;
}

@end
