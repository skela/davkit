//
//  DKPrefs.m
//  DavKit
//
//  Created by Aleksander Slater on 05/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "DKPrefs.h"

#ifndef DK_CURRENT_USER_SYNC_ON_SET
#define DK_CURRENT_USER_SYNC_ON_SET YES
#endif

@implementation DKPrefs

+ (void)clear
{
    
}

#pragma mark - Generic

+ (NSUserDefaults*)defaults
{
    return [NSUserDefaults standardUserDefaults];
}

+ (BOOL)sync
{
    return [[DKPrefs defaults] synchronize];
}

+ (BOOL)syncOnSet
{
    return DK_CURRENT_USER_SYNC_ON_SET;
}

+ (void)setBool:(BOOL)b withKey:(NSString*)key
{
    [DKPrefs setObject:[NSNumber numberWithBool:b] ofClass:[NSNumber class] withKey:key];
}

+ (void)setInteger:(NSInteger)i withKey:(NSString*)key
{
    [DKPrefs setObject:[NSNumber numberWithInteger:i] ofClass:[NSNumber class] withKey:key];
}

+ (void)setLong:(long)l withKey:(NSString*)key
{
    [DKPrefs setObject:[NSNumber numberWithLong:l] ofClass:[NSNumber class] withKey:key];
}

+ (void)setLongLong:(long long)ll withKey:(NSString*)key
{
    [DKPrefs setObject:[NSNumber numberWithLongLong:ll] ofClass:[NSNumber class] withKey:key];
}

+ (void)setDate:(NSDate*)d withKey:(NSString*)key
{
    [DKPrefs setObject:[NSNumber numberWithDouble:[d timeIntervalSince1970]] ofClass:[NSNumber class] withKey:key];
}

+ (void)setDictionary:(NSDictionary*)d withKey:(NSString*)key
{
    [DKPrefs setObject:d ofClass:[NSDictionary class] withKey:key];
}

+ (void)setDouble:(double)d withKey:(NSString*)key
{
    [DKPrefs setObject:[NSNumber numberWithDouble:d] ofClass:[NSNumber class] withKey:key];
}

+ (void)setFloat:(CGFloat)f withKey:(NSString*)key
{
    [DKPrefs setObject:[NSNumber numberWithFloat:f] ofClass:[NSNumber class] withKey:key];
}

+ (BOOL)getBoolForKey:(NSString*)key defaultValue:(BOOL)def
{
    NSNumber *n = [DKPrefs getNumberForKey:key defaultValue:nil]; return n==nil ? def : [n boolValue];
}

+ (NSInteger)getIntegerForKey:(NSString*)key defaultValue:(NSInteger)def
{
    NSNumber *n = [DKPrefs getNumberForKey:key defaultValue:nil]; return n==nil ? def : [n integerValue];
}

+ (long)getLongForKey:(NSString*)key defaultValue:(long)def
{
    NSNumber *n = [DKPrefs getNumberForKey:key defaultValue:nil]; return n==nil ? def : [n longValue];
}

+ (long long)getLongLongForKey:(NSString*)key defaultValue:(long long)def
{
    NSNumber *n = [DKPrefs getNumberForKey:key defaultValue:nil]; return n==nil ? def : [n longLongValue];
}

+ (double)getDoubleForKey:(NSString*)key defaultValue:(double)def
{
    NSNumber *n = [DKPrefs getNumberForKey:key defaultValue:nil]; return n==nil ? def : [n doubleValue];
}

+ (CGFloat)getFloatForKey:(NSString*)key defaultValue:(CGFloat)def
{
    NSNumber *n = [DKPrefs getNumberForKey:key defaultValue:nil]; return n==nil ? def : [n floatValue];
}

+ (NSDate*)getDateForKey:(NSString*)key defaultValue:(NSDate*)def
{
    NSNumber *n = [DKPrefs getNumberForKey:key defaultValue:nil]; return n==nil ? def : [NSDate dateWithTimeIntervalSince1970:[n doubleValue]];
}

+ (NSDictionary*)getDictionaryForKey:(NSString*)key defaultValue:(NSDictionary*)def
{
    return [DKPrefs getObjectOfClass:[NSDictionary class] forKey:key defaultValue:def];
}

+ (id)getObjectOfClass:(Class)class forKey:(NSString*)key defaultValue:(id)def
{
    id obj = [[DKPrefs defaults] objectForKey:key];
    if (obj==nil || ![obj isKindOfClass:class])
        return def;
    return obj;
}

+ (void)removeObjectForKey:(NSString*)key
{
    [[DKPrefs defaults] removeObjectForKey:key];
}

+ (void)setObject:(id)obj ofClass:(Class)class withKey:(NSString*)key
{
    if (obj==nil || ![obj isKindOfClass:class])
        [self removeObjectForKey:key];
    else
        [[DKPrefs defaults] setObject:obj forKey:key];
    
    if ([[self class] syncOnSet]) [self sync];
}

+ (BOOL)hasObjectOfClass:(Class)class withKey:(NSString*)key
{
    id obj = [[DKPrefs defaults] objectForKey:key];
    if (obj==nil || ![obj isKindOfClass:class])
        return NO;
    return YES;
}

+ (BOOL)hasObjectWithKey:(NSString*)key
{
    return [DKPrefs hasObjectOfClass:[NSObject class] withKey:key];
}

+ (NSArray*)getArrayForKey:(NSString*)key defaultValue:(NSArray*)def
{
    return [DKPrefs getObjectOfClass:[NSArray class] forKey:key defaultValue:def];
}

+ (NSData*)getDataForKey:(NSString*)key defaultValue:(NSData*)def
{
    return [DKPrefs getObjectOfClass:[NSData class] forKey:key defaultValue:def];
}

+ (NSString*)getStringForKey:(NSString*)key defaultValue:(NSString*)def
{
    return [DKPrefs getObjectOfClass:[NSString class] forKey:key defaultValue:def];
}

+ (NSNumber*)getNumberForKey:(NSString*)key defaultValue:(NSNumber*)def
{
    return [DKPrefs getObjectOfClass:[NSNumber class] forKey:key defaultValue:def];
}

+ (void)setArray:(NSArray*)ar withKey:(NSString*)key
{
    [DKPrefs setObject:ar ofClass:[NSArray class] withKey:key];
}

+ (void)setData:(NSData*)ar withKey:(NSString*)key
{
    [DKPrefs setObject:ar ofClass:[NSData class] withKey:key];
}

+ (void)setString:(NSString*)ar withKey:(NSString*)key
{
    [DKPrefs setObject:ar ofClass:[NSString class] withKey:key];
}

+ (void)setNumber:(NSNumber*)ar withKey:(NSString*)key
{
    [DKPrefs setObject:ar ofClass:[NSNumber class] withKey:key];    
}

+ (BOOL)hasStringWithKey:(NSString*)key
{
    return [DKPrefs hasObjectOfClass:[NSString class] withKey:key];
}

+ (BOOL)hasArrayWithKey:(NSString*)key
{
    return [DKPrefs hasObjectOfClass:[NSArray class] withKey:key];
}

+ (BOOL)hasDictionaryWithKey:(NSString*)key
{
    return [DKPrefs hasObjectOfClass:[NSDictionary class] withKey:key];
}

+ (BOOL)hasNumberWithKey:(NSString*)key
{
    return [DKPrefs hasObjectOfClass:[NSNumber class] withKey:key];
}

@end
