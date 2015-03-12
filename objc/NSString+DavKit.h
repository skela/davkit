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

typedef enum
{
    HashingMethodMD5,
    HashingMethodSHA1,
    HashingMethodSHA224,
    HashingMethodSHA256,
    HashingMethodSHA384,
    HashingMethodSHA512,
} HashingMethod;

typedef enum
{
    EncryptionMethodBlowfish
} EncryptionMethod;

@interface NSString (DavKit)
- (BOOL)contains:(NSString*)subString;
- (NSUInteger)numberOfOccurrences:(NSString*)subString;
- (BOOL)containsPattern:(NSString*)pattern;
- (NSData*)stringToBase64EncodedData;
- (NSURL*)URL;
- (NSString*)dotFilePath;
- (BOOL)isInteger;
- (BOOL)isNumber;
- (BOOL)isEmail;
- (NSDictionary*)fromJSON;
- (NSString*)strip;
- (NSString *)extractStringLookingFor:(NSString *)lookFor skipForwardTo:(NSInteger)skipForward andStopBefore:(NSString *)stopBefore;
- (NSString *)extractStringLookingFor:(NSString *)lookFor andStopBefore:(NSString *)stopBefore;
- (NSString*)first;
- (NSString *)stringByHashing:(HashingMethod)hashMethod;
- (NSString *)stringByEncrypting:(EncryptionMethod)encryptionMethod withKey:(NSString*)key;
- (NSString *)stringByDecrypting:(EncryptionMethod)encryptionMethod withKey:(NSString*)key;
- (NSString *)stringForPath;
+ (NSString*)uuid;

- (NSString*)MD5;
- (NSString*)SHA1;
- (NSString*)SHA256;

@end

@interface DKStringHelper : NSObject
+ (NSString*)hexDataToString:(NSData*)data;
+ (NSData *)dataFromHexString:(NSString*)string;
+ (int)digestLengthForHashingMethod:(HashingMethod)hashingMethod;
+ (NSData*)hexDataForString:(NSString*)string usingHashMethod:(HashingMethod)hashMethod;
+ (NSString *)stringForPath:(NSString *)fileName;
@end

@interface DKEncryptor : NSObject

+ (NSString *)encryptString:(NSString*)string usingMethod:(EncryptionMethod)encryptionMethod withKey:(NSString*)key;
+ (NSString *)decryptString:(NSString*)string usingMethod:(EncryptionMethod)encryptionMethod withKey:(NSString*)key;

+ (NSString*)encryptString:(NSString*)string usingBlowfishWithKey:(NSString*)key;
+ (NSData*)encryptedDataForString:(NSString*)string usingBlowfishWithKey:(NSString*)key;
+ (NSString*)decryptString:(NSString*)string usingBlowfishWithKey:(NSString*)key;
+ (NSData*)decryptedDataForString:(NSString*)string usingBlowfishWithKey:(NSString*)key;

@end
