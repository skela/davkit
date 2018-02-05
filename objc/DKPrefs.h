//
//  DKCurrentUser.h
//  DavKit
//
//  Created by Aleksander Slater on 05/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

// Subclass or wrap this in your own CurrentUser / Settings class
// for maximum potential.

@interface DKPrefs : NSObject

+ (void)clear;
+ (BOOL)sync;
+ (BOOL)syncOnSet;

+ (void)removeObjectForKey:(nonnull NSString*)key;

+ (void)setLong:(long)l withKey:(nonnull NSString*)key;
+ (void)setLongLong:(long long)ll withKey:(nonnull NSString*)key;
+ (void)setBool:(BOOL)b withKey:(nonnull NSString*)key;
+ (void)setInteger:(NSInteger)i withKey:(nonnull NSString*)key;
+ (void)setDate:(nullable NSDate*)d withKey:(nonnull NSString*)key;
+ (void)setDouble:(double)d withKey:(nonnull NSString*)key;
+ (void)setFloat:(float)f withKey:(nonnull NSString*)key;
+ (void)setCGFloat:(CGFloat)f withKey:(nonnull NSString*)key;
+ (void)setDictionary:(nullable NSDictionary*)d withKey:(nonnull NSString*)key;
+ (BOOL)getBoolForKey:(nonnull NSString*)key defaultValue:(BOOL)def;
+ (NSInteger)getIntegerForKey:(nonnull NSString*)key defaultValue:(NSInteger)def;
+ (long)getLongForKey:(nonnull NSString*)key defaultValue:(long)def;
+ (long long)getLongLongForKey:(nonnull NSString*)key defaultValue:(long long)def;
+ (double)getDoubleForKey:(nonnull NSString*)key defaultValue:(double)def;
+ (nullable NSDate*)getDateForKey:(nonnull NSString*)key defaultValue:(nullable NSDate*)def;
+ (nullable NSDictionary*)getDictionaryForKey:(nonnull NSString*)key defaultValue:(nullable NSDictionary*)def;
+ (CGFloat)getCGFloatForKey:(nonnull NSString*)key defaultValue:(CGFloat)def;
+ (float)getFloatForKey:(nonnull NSString*)key defaultValue:(float)def;
+ (nullable NSArray*)getArrayForKey:(nonnull NSString*)key defaultValue:(nullable NSArray*)def;
+ (void)setArray:(nullable NSArray*)ar withKey:(nonnull NSString*)key;
+ (nullable NSString*)getStringForKey:(nonnull NSString*)key defaultValue:(nullable NSString*)def;
+ (void)setString:(nullable NSString*)ar withKey:(nonnull NSString*)key;
+ (nullable NSNumber*)getNumberForKey:(nonnull NSString*)key defaultValue:(nullable NSNumber*)def;
+ (void)setNumber:(nullable NSNumber*)ar withKey:(nonnull NSString*)key;
+ (void)setData:(nullable NSData*)ar withKey:(nonnull NSString*)key;
+ (nullable NSData*)getDataForKey:(nonnull NSString*)key defaultValue:(nullable NSData*)def;
+ (BOOL)hasObjectWithKey:(nonnull NSString*)key;
+ (BOOL)hasStringWithKey:(nonnull NSString*)key;
+ (BOOL)hasArrayWithKey:(nonnull NSString*)key;
+ (BOOL)hasDictionaryWithKey:(nonnull NSString*)key;
+ (BOOL)hasNumberWithKey:(nonnull NSString*)key;

@end
