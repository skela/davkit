//
//  NSString+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 13/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "NSString+DavKit.h"
#import "NSString+DavKit_Digests.h"
#import "UIText+DavKit.h"
#import "NSData+DavKit.h"
#import "DKParser.h"

@implementation NSString (DavKit_Digests)

- (NSString*)MD5
{
    return [self stringByHashing:HashingMethodMD5];
}

- (NSString*)SHA1
{
    return [self stringByHashing:HashingMethodSHA1];
}

- (NSString*)SHA224
{
    return [self stringByHashing:HashingMethodSHA224];
}

- (NSString*)SHA256
{
    return [self stringByHashing:HashingMethodSHA256];
}

- (NSString*)SHA384
{
    return [self stringByHashing:HashingMethodSHA384];
}

- (NSString*)SHA512
{
    return [self stringByHashing:HashingMethodSHA512];
}

- (NSString *)stringByHashing:(HashingMethod)hashMethod
{
    NSData *hexData = [DKStringHelper hexDataForString:self usingHashMethod:hashMethod];
    return [DKStringHelper hexDataToString:hexData];
}

@end
