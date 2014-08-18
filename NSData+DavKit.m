//
//  NSData+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 08/01/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
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
        #pragma GCC diagnostic push
        #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        string = [self base64Encoding];                              // pre iOS7
        #pragma GCC diagnostic pop
    }
    return string;
}

@end
