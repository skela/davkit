//
//  NSString+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 13/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "NSString+DavKit.h"
#import "UIText+DavKit.h"
#import "DavKit.h"

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

- (NSDictionary*)fromJSON
{
    return [DKParser fromJSONString:self];
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
        #pragma GCC diagnostic push
        #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        data = [[NSData alloc] initWithBase64Encoding:self];                           // pre iOS7
        #pragma GCC diagnostic pop
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
#define REGEX_FOR_EMAIL @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}"

- (BOOL)isInteger
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_FOR_INTEGERS] evaluateWithObject:self];
}

- (BOOL)isNumber
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_FOR_NUMBERS] evaluateWithObject:self];
}

- (BOOL)isEmail
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_FOR_EMAIL] evaluateWithObject:self];
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

- (NSString*)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
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

- (NSString *)stringForPath
{
    return [DKStringHelper stringForPath:self];
}

@end

@implementation DKStringHelper

+ (NSString *)hexDataToString:(NSData*)data
{
    NSUInteger length = data.length;
    const unsigned char* buffer = data.bytes;
    if (buffer==nil || length==0)
        return nil;
    NSMutableString *mstr = [NSMutableString new];
    for (NSUInteger i = 0; i < length; i++)
        [mstr appendFormat:@"%02x", buffer[i]];
    return [NSString stringWithString:mstr];
}

+ (int)digestLengthForHashingMethod:(HashingMethod)hashingMethod
{
    switch (hashingMethod)
    {
        case HashingMethodMD5:
            return CC_MD5_DIGEST_LENGTH;
        case HashingMethodSHA1:
            return CC_SHA1_DIGEST_LENGTH;
        case HashingMethodSHA224:
            return CC_SHA224_DIGEST_LENGTH;
        case HashingMethodSHA256:
            return CC_SHA256_DIGEST_LENGTH;
        case HashingMethodSHA384:
            return CC_SHA384_DIGEST_LENGTH;
        case HashingMethodSHA512:
            return CC_SHA512_DIGEST_LENGTH;
    }
}

+ (NSData*)hexDataForString:(NSString*)string usingHashMethod:(HashingMethod)hashingMethod
{
    int len = [DKStringHelper digestLengthForHashingMethod:hashingMethod];
    unsigned char buffer[len];
    if (len < 0)
        return nil;
    switch (hashingMethod)
    {
        case HashingMethodMD5:
            CC_MD5(string.UTF8String, (CC_LONG)string.length, buffer);
            break;
        case HashingMethodSHA1:
            CC_SHA1(string.UTF8String, (CC_LONG)string.length, buffer);
            break;
        case HashingMethodSHA224:
            CC_SHA224(string.UTF8String, (CC_LONG)string.length, buffer);
            break;
        case HashingMethodSHA256:
            CC_SHA256(string.UTF8String, (CC_LONG)string.length, buffer);
            break;
        case HashingMethodSHA384:
            CC_SHA384(string.UTF8String, (CC_LONG)string.length, buffer);
            break;
        case HashingMethodSHA512:
            CC_SHA512(string.UTF8String, (CC_LONG)string.length, buffer);
            break;
    }
    return [NSData dataWithBytes:buffer length:len];
}

+ (NSString *)stringForPath:(NSString *)fileName
{
    if (fileName==nil || fileName.length==0)
        return fileName;
    NSCharacterSet* illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    return [[fileName componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
}

@end
