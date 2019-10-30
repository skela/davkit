//
//  NSString+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 13/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+DavKit.h"

@interface NSString (DavKit_Digests)
- (NSString *)stringByHashing:(HashingMethod)hashMethod;
- (NSString*)MD5;
- (NSString*)SHA1;
- (NSString*)SHA224;
- (NSString*)SHA256;
@end
