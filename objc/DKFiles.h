//
//  DKFiles.h
//  Constructor
//
//  Created by Aleksander Slater on 19/05/2015.
//  Copyright (c) 2015 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKFiles : NSObject
+ (NSString*)md5ForFileAtPath:(NSString*)path;
+ (NSString*)md5ForFileAtURL:(NSURL*)url;
+ (NSString*)sha1ForFileAtPath:(NSString *)filePath;
+ (NSString*)sha1ForFileAtURL:(NSURL*)url;
+ (NSString*)sha256ForFileAtPath:(NSString *)filePath;
+ (NSString*)sha256ForFileAtURL:(NSURL*)url;
+ (NSString*)sha512ForFileAtPath:(NSString *)filePath;
+ (NSString*)sha512ForFileAtURL:(NSURL*)url;
+ (NSString*)md5ForFileWithHandle:(NSFileHandle*)fileHandle;
+ (NSString*)sha1ForFileWithHandle:(NSFileHandle*)fileHandle;
+ (NSString*)sha512ForFileWithHandle:(NSFileHandle*)fileHandle;
@end
