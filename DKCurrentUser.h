//
//  DKCurrentUser.h
//  DavKit
//
//  Created by Aleksander Slater on 05/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

// Subclass or wrap this in your own CurrentUser / Settings class
// for maximum potential.

@interface DKCurrentUser : NSObject

+ (void)clear;
+ (BOOL)sync;
+ (BOOL)syncOnSet;

+ (void)setLong:(long)l withKey:(NSString*)key;
+ (void)setLongLong:(long long)ll withKey:(NSString*)key;
+ (void)setBool:(BOOL)b withKey:(NSString*)key;
+ (void)setInteger:(NSInteger)i withKey:(NSString*)key;
+ (void)setDate:(NSDate*)d withKey:(NSString*)key;
+ (void)setDouble:(double)d withKey:(NSString*)key;
+ (void)setFloat:(CGFloat)f withKey:(NSString*)key;
+ (void)setDictionary:(NSDictionary*)d withKey:(NSString*)key;
+ (BOOL)getBoolForKey:(NSString*)key defaultValue:(BOOL)def;
+ (NSInteger)getIntegerForKey:(NSString*)key defaultValue:(NSInteger)def;
+ (long)getLongForKey:(NSString*)key defaultValue:(long)def;
+ (long long)getLongLongForKey:(NSString*)key defaultValue:(long long)def;
+ (double)getDoubleForKey:(NSString*)key defaultValue:(double)def;
+ (NSDate*)getDateForKey:(NSString*)key defaultValue:(NSDate*)def;
+ (NSDictionary*)getDictionaryForKey:(NSString*)key defaultValue:(NSDictionary*)def;
+ (CGFloat)getFloatForKey:(NSString*)key defaultValue:(CGFloat)def;
+ (NSArray*)getArrayForKey:(NSString*)key defaultValue:(NSArray*)def;
+ (void)setArray:(NSArray*)ar withKey:(NSString*)key;
+ (NSString*)getStringForKey:(NSString*)key defaultValue:(NSString*)def;
+ (void)setString:(NSString*)ar withKey:(NSString*)key;
+ (NSNumber*)getNumberForKey:(NSString*)key defaultValue:(NSNumber*)def;
+ (void)setNumber:(NSNumber*)ar withKey:(NSString*)key;
+ (void)setData:(NSData*)ar withKey:(NSString*)key;
+ (NSData*)getDataForKey:(NSString*)key defaultValue:(NSData*)def;
+ (BOOL)hasObjectWithKey:(NSString*)key;
+ (BOOL)hasStringWithKey:(NSString*)key;
+ (BOOL)hasArrayWithKey:(NSString*)key;
+ (BOOL)hasDictionaryWithKey:(NSString*)key;
+ (BOOL)hasNumberWithKey:(NSString*)key;

@end
