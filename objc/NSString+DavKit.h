//
//  NSString+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 13/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (DavKit)
- (BOOL)contains:(NSString*)subString;
- (NSUInteger)numberOfOccurrences:(NSString*)subString;
- (BOOL)containsPattern:(NSString*)pattern;
- (NSData*)stringToBase64EncodedData;
- (NSURL*)URL;
- (NSString*)dotFilePath;
- (BOOL)isInteger;
- (BOOL)isNumber;
- (NSString*)strip;
- (NSString *)extractStringLookingFor:(NSString *)lookFor skipForwardTo:(NSInteger)skipForward andStopBefore:(NSString *)stopBefore;
- (NSString *)extractStringLookingFor:(NSString *)lookFor andStopBefore:(NSString *)stopBefore;
- (NSString*)first;
- (NSString*)MD5;

@end
