//
//  NSString+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 13/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
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

// TODO: Move into UI Category
- (CGSize)sizeUsingFont:(UIFont *)font;
- (CGSize)sizeUsingFont:(UIFont*)font constrainedToSize:(CGSize)constraint lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
