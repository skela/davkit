//
//  NSString+DavKit.h
//  Constructor
//
//  Created by Aleksander Slater on 13/09/2013.
//  Copyright (c) 2013 IntroLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DavKit)
- (BOOL)contains:(NSString*)subString;
- (NSUInteger)numberOfOccurrences:(NSString*)subString;
- (BOOL)containsPattern:(NSString*)pattern;
- (NSData*)stringToBase64EncodedData;
- (NSURL*)URL;
- (NSString*)dotFilePath;
- (BOOL)isInteger;
- (BOOL)isNumber;
@end
