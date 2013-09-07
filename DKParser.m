//
//  DKParser.m
//  DAVKIT
//
//  Created by Aleksander Slater on 09/06/2012.
//  Copyright (c) 2012 Davincium. All rights reserved.
//

#import "DKParser.h"

@implementation DKParser

+ (NSString*)getString:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSString*)fallBack
{
    NSString *str=[d objectForKey:key];
    if (str!=nil && [str isKindOfClass:[NSString class]])
        return str;
    return fallBack;
}

+ (NSInteger)getInteger:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSInteger)fallBack
{
    NSNumber *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSNumber class]])
        return [n integerValue];
    return fallBack;
}

+ (long long)getLongLong:(NSDictionary*)d forKey:(NSString*)key fallBack:(long long)fallBack
{
    NSNumber *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSNumber class]])
        return [n longLongValue];
    return fallBack;
}

+ (BOOL)getBool:(NSDictionary*)d forKey:(NSString*)key fallBack:(BOOL)fallBack
{
    NSNumber *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSNumber class]])
        return [n boolValue];
    return fallBack;
}

+ (double)getDouble:(NSDictionary*)d forKey:(NSString*)key fallBack:(double)fallBack
{
    NSNumber *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSNumber class]])
        return [n doubleValue];
    return fallBack;
}

+ (CGFloat)getFloat:(NSDictionary*)d forKey:(NSString*)key fallBack:(CGFloat)fallBack
{
    NSNumber *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSNumber class]])
        return [n floatValue];
    return fallBack;
}

+ (long)getLong:(NSDictionary*)d forKey:(NSString*)key fallBack:(long)fallBack
{
    NSNumber *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSNumber class]])
        return [n longValue];
    return fallBack;
}

+ (NSArray*)getArray:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSArray*)fallBack
{
    NSArray *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSArray class]])
        return n;
    return fallBack;
}

+ (NSDictionary*)getDictionary:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSDictionary*)fallBack
{
    NSDictionary *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSDictionary class]])
        return n;
    return fallBack;
}

+ (BOOL)isDictionary:(id)d
{
    if (d!=nil && [d isKindOfClass:[NSDictionary class]])
        return YES;
    return NO;
}

+ (BOOL)isNumber:(id)number
{
    if (number!=nil && [number isKindOfClass:[NSNumber class]])
        return YES;
    return NO;
}

+ (BOOL)isString:(id)string
{
    if (string!=nil && [string isKindOfClass:[NSString class]] && [string length]>0)
        return YES;
    return NO;
}

+ (BOOL)isArray:(id)ar
{
    if (ar!=nil && [ar isKindOfClass:[NSArray class]])
        return YES;
    return NO;
}

@end
