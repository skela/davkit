//
//  DKFiles.m
//  Constructor
//
//  Created by Aleksander Slater on 19/05/2015.
//  Copyright (c) 2015 Davincium. All rights reserved.
//

#import "DKFiles.h"
#import "NSString+DavKit.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CommonCrypto/CommonDigest.h>

#include <stdint.h>
#include <stdio.h>

// FROM : https://raw.githubusercontent.com/JoeKun/FileMD5Hash/master/Library/FileHash.m

/*
 *  FileHash.m
 *  FileMD5Hash
 *
 *  Copyright © 2010-2014 Joel Lopes Da Silva. All rights reserved.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

// Constants
static const size_t FileHashDefaultChunkSizeForReadingData = 4096;

// Function pointer types for functions used in the computation
// of a cryptographic hash.
typedef int (*FileHashInitFunction)   (uint8_t *hashObjectPointer[]);
typedef int (*FileHashUpdateFunction) (uint8_t *hashObjectPointer[], const void *data, CC_LONG len);
typedef int (*FileHashFinalFunction)  (unsigned char *md, uint8_t *hashObjectPointer[]);

// Structure used to describe a hash computation context.
typedef struct _FileHashComputationContext {
    FileHashInitFunction initFunction;
    FileHashUpdateFunction updateFunction;
    FileHashFinalFunction finalFunction;
    size_t digestLength;
    uint8_t **hashObjectPointer;
} FileHashComputationContext;

#define FileHashComputationContextInitialize(context, hashAlgorithmName)                    \
CC_##hashAlgorithmName##_CTX hashObjectFor##hashAlgorithmName;                          \
context.initFunction      = (FileHashInitFunction)&CC_##hashAlgorithmName##_Init;       \
context.updateFunction    = (FileHashUpdateFunction)&CC_##hashAlgorithmName##_Update;   \
context.finalFunction     = (FileHashFinalFunction)&CC_##hashAlgorithmName##_Final;     \
context.digestLength      = CC_##hashAlgorithmName##_DIGEST_LENGTH;                     \
context.hashObjectPointer = (uint8_t **)&hashObjectFor##hashAlgorithmName

@implementation DKFiles

+ (NSString *)hashOfFileAtPath:(NSString *)filePath withComputationContext:(FileHashComputationContext *)context
{
    NSString *result = nil;
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)filePath, kCFURLPOSIXPathStyle, (Boolean)false);
    CFReadStreamRef readStream = fileURL ? CFReadStreamCreateWithFile(kCFAllocatorDefault, fileURL) : NULL;
    BOOL didSucceed = readStream ? (BOOL)CFReadStreamOpen(readStream) : NO;
    if (didSucceed) {
        
        // Use default value for the chunk size for reading data.
        const size_t chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
        
        // Initialize the hash object
        (*context->initFunction)(context->hashObjectPointer);
        
        // Feed the data to the hash object.
        BOOL hasMoreData = YES;
        while (hasMoreData) {
            uint8_t buffer[chunkSizeForReadingData];
            CFIndex readBytesCount = CFReadStreamRead(readStream, (UInt8 *)buffer, (CFIndex)sizeof(buffer));
            if (readBytesCount == -1) {
                break;
            } else if (readBytesCount == 0) {
                hasMoreData = NO;
            } else {
                (*context->updateFunction)(context->hashObjectPointer, (const void *)buffer, (CC_LONG)readBytesCount);
            }
        }
        
        // Compute the hash digest
        unsigned char digest[context->digestLength];
        (*context->finalFunction)(digest, context->hashObjectPointer);
        
        // Close the read stream.
        CFReadStreamClose(readStream);
        
        // Proceed if the read operation succeeded.
        didSucceed = !hasMoreData;
        if (didSucceed) {
            char hash[2 * sizeof(digest) + 1];
            for (size_t i = 0; i < sizeof(digest); ++i) {
                snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
            }
            result = [NSString stringWithUTF8String:hash];
        }
        
    }
    if (readStream) CFRelease(readStream);
    if (fileURL)    CFRelease(fileURL);
    return result;
}

+ (NSString *)hashOfFileHandle:(NSFileHandle *)fileHandle withComputationContext:(FileHashComputationContext *)context
{
    NSString *result = nil;
    
    // Use default value for the chunk size for reading data.
    const size_t chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    
    // Initialize the hash object
    (*context->initFunction)(context->hashObjectPointer);
    
    // Feed the data to the hash object.
    BOOL hasMoreData = YES;
    while (hasMoreData)
    {
        uint8_t buffer[chunkSizeForReadingData];
        
        NSData *data = [fileHandle readDataOfLength:chunkSizeForReadingData];
        
        if ([data length]==0)
        {
            hasMoreData = NO;
            break;
        }

        [data getBytes:buffer length:chunkSizeForReadingData];
        
        (*context->updateFunction)(context->hashObjectPointer, (const void *)buffer, (CC_LONG)[data length]);
    }
    
    // Compute the hash digest
    unsigned char digest[context->digestLength];
    (*context->finalFunction)(digest, context->hashObjectPointer);
    
    // Proceed if the read operation succeeded.
    BOOL didSucceed = !hasMoreData;
    if (didSucceed)
    {
        char hash[2 * sizeof(digest) + 1];
        for (size_t i = 0; i < sizeof(digest); ++i) {
            snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
        }
        result = [NSString stringWithUTF8String:hash];
    }
    
    return result;
}

+ (NSString*)fileHash:(HashingMethod)method forFile:(id)file
{
    FileHashComputationContext context;
    switch (method)
    {
        case HashingMethodMD5:
        {
            FileHashComputationContextInitialize(context, MD5);
        } break;
        case HashingMethodSHA1:
        {
            FileHashComputationContextInitialize(context, SHA1);
        } break;
        case HashingMethodSHA256:
        {
            FileHashComputationContextInitialize(context, SHA256);
        } break;
        case HashingMethodSHA512:
        {
            FileHashComputationContextInitialize(context, SHA512);
        } break;
        case HashingMethodSHA224:
        case HashingMethodSHA384:
        {
            NSLog(@"Unsupported hashing method - Only MD5,SHA1,SHA256 or SHA512 can be used for file hashes");
            return nil;
        } break;
    }
    
    if ([file isKindOfClass:[NSURL class]])
    {
        NSURL *fileUrl = file;
        NSString *filePath = [fileUrl path];
        return [self hashOfFileAtPath:filePath withComputationContext:&context];
    }
    else if ([file isKindOfClass:[NSString class]])
    {
        NSString *filePath = file;
        return [self hashOfFileAtPath:filePath withComputationContext:&context];
    }
    else if ([file isKindOfClass:[NSFileHandle class]])
    {
        NSFileHandle *fileHandle = file;
        return [self hashOfFileHandle:fileHandle withComputationContext:&context];
    }
    return nil;
}

+ (NSString *)md5ForFileAtPath:(NSString *)filePath
{
    return [DKFiles fileHash:HashingMethodMD5 forFile:filePath];
}

+ (NSString *)sha1ForFileAtPath:(NSString *)filePath
{
    return [DKFiles fileHash:HashingMethodSHA1 forFile:filePath];
}

+ (NSString *)sha512ForFileAtPath:(NSString *)filePath
{
    return [DKFiles fileHash:HashingMethodSHA512 forFile:filePath];
}

+ (NSString*)md5ForFileAtURL:(NSURL*)url
{
    return [DKFiles fileHash:HashingMethodMD5 forFile:url];
}

+ (NSString*)sha1ForFileAtURL:(NSURL*)url
{
    return [DKFiles fileHash:HashingMethodSHA1 forFile:url];
}

+ (NSString*)sha512ForFileAtURL:(NSURL*)url
{
    return [DKFiles fileHash:HashingMethodSHA512 forFile:url];
}

+ (NSString*)md5ForFileWithHandle:(NSFileHandle*)fileHandle
{
    return [DKFiles fileHash:HashingMethodMD5 forFile:fileHandle];
}

+ (NSString*)sha1ForFileWithHandle:(NSFileHandle*)fileHandle
{
    return [DKFiles fileHash:HashingMethodSHA1 forFile:fileHandle];
}

+ (NSString*)sha512ForFileWithHandle:(NSFileHandle*)fileHandle
{
    return [DKFiles fileHash:HashingMethodSHA512 forFile:fileHandle];
}

@end
