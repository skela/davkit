//
//  DKCurrentUser.m
//  DAVKIT
//
//  Created by Aleksander Slater on 05/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "DKCurrentUser.h"

@implementation DKCurrentUser

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
    return [[DKCurrentUser defaults] synchronize];
}

+ (void)setBool:(BOOL)b withKey:(NSString*)key
{
    [[DKCurrentUser defaults] setObject:[NSNumber numberWithBool:b] forKey:key];
}

+ (BOOL)getBoolForKey:(NSString*)key defaultValue:(BOOL)def
{
    NSNumber * n =[[DKCurrentUser defaults] objectForKey:key];
    if (n==nil)
        return def;
    return [n boolValue];
}

+ (void)setInteger:(NSInteger)i withKey:(NSString*)key
{
    [[DKCurrentUser defaults] setObject:[NSNumber numberWithInteger:i] forKey:key];
}

+ (NSInteger)getIntegerForKey:(NSString*)key defaultValue:(NSInteger)def
{
    NSNumber * n =[[DKCurrentUser defaults] objectForKey:key];
    if (n==nil)
        return def;
    return [n integerValue];
}

+ (id)getObjectOfClass:(Class)class forKey:(NSString*)key defaultValue:(id)def
{
    id obj = [[DKCurrentUser defaults] objectForKey:key];
    if (obj==nil || ![obj isKindOfClass:class])
        return def;
    return obj;
}

+ (void)setObject:(id)obj ofClass:(Class)class withKey:(NSString*)key
{
    if (obj==nil || ![obj isKindOfClass:class])
        [[DKCurrentUser defaults] removeObjectForKey:key];
    else
        [[DKCurrentUser defaults] setObject:obj forKey:key];
}

+ (BOOL)hasObjectOfClass:(Class)class withKey:(NSString*)key
{
    id obj = [[DKCurrentUser defaults] objectForKey:key];
    if (obj==nil || ![obj isKindOfClass:class])
        return NO;
    return YES;
}

+ (BOOL)hasObjectWithKey:(NSString*)key
{
    return [DKCurrentUser hasObjectOfClass:[NSObject class] withKey:key];
}

+ (NSArray*)getArrayForKey:(NSString*)key defaultValue:(NSArray*)def
{
    return [DKCurrentUser getObjectOfClass:[NSArray class] forKey:key defaultValue:def];
}

+ (NSString*)getStringForKey:(NSString*)key defaultValue:(NSString*)def
{
    return [DKCurrentUser getObjectOfClass:[NSString class] forKey:key defaultValue:def];
}

+ (NSNumber*)getNumberForKey:(NSString*)key defaultValue:(NSNumber*)def
{
    return [DKCurrentUser getObjectOfClass:[NSNumber class] forKey:key defaultValue:def];
}

+ (void)setArray:(NSArray*)ar withKey:(NSString*)key
{
    [DKCurrentUser setObject:ar ofClass:[NSArray class] withKey:key];
}

+ (void)setString:(NSString*)ar withKey:(NSString*)key
{
    [DKCurrentUser setObject:ar ofClass:[NSString class] withKey:key];
}

+ (void)setNumber:(NSNumber*)ar withKey:(NSString*)key
{
    [DKCurrentUser setObject:ar ofClass:[NSNumber class] withKey:key];    
}

+ (BOOL)hasStringWithKey:(NSString*)key
{
    return [DKCurrentUser hasObjectOfClass:[NSString class] withKey:key];
}

+ (BOOL)hasArrayWithKey:(NSString*)key
{
    return [DKCurrentUser hasObjectOfClass:[NSArray class] withKey:key];
}

+ (BOOL)hasDictionaryWithKey:(NSString*)key
{
    return [DKCurrentUser hasObjectOfClass:[NSDictionary class] withKey:key];
}

+ (BOOL)hasNumberWithKey:(NSString*)key
{
    return [DKCurrentUser hasObjectOfClass:[NSNumber class] withKey:key];
}

@end
