//
//  NSDictionary+DavKit.m
//  Constructor
//
//  Created by Aleksander Slater on 17/12/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import "NSDictionary+DavKit.h"

@implementation NSDictionary (DavKit)

- (NSValue*)getValue:(NSString*)key fallback:(NSValue*)fallBack
{
    return [DKParser getObject:self ofClass:[NSValue class] forKey:key fallback:fallBack];
}

- (NSNumber*)getNumber:(NSString*)key fallback:(NSNumber*)fallBack
{
    return [DKParser getObject:self ofClass:[NSNumber class] forKey:key fallback:fallBack];
}

- (NSString*)getString:(NSString*)key fallback:(NSString*)fallBack
{
    return [DKParser getObject:self ofClass:[NSString class] forKey:key fallback:fallBack];
}

- (NSArray*)getArray:(NSString*)key fallback:(NSArray*)fallBack
{
    return [DKParser getObject:self ofClass:[NSArray class] forKey:key fallback:fallBack];
}

- (NSDictionary*)getDictionary:(NSString*)key fallback:(NSDictionary*)fallBack
{
    return [DKParser getObject:self ofClass:[NSDictionary class] forKey:key fallback:fallBack];
}

- (NSInteger)getInteger:(NSString*)key fallback:(NSInteger)fallBack
{
    return [DKParser getInteger:self forKey:key fallback:fallBack];
}

- (long long)getLongLong:(NSString*)key fallback:(long long)fallBack
{
    return [DKParser getLongLong:self forKey:key fallback:fallBack];
}

- (BOOL)getBool:(NSString*)key fallback:(BOOL)fallBack
{
    return [DKParser getBool:self forKey:key fallback:fallBack];
}

- (double)getDouble:(NSString*)key fallback:(double)fallBack
{
    return [DKParser getDouble:self forKey:key fallback:fallBack];
}

- (CGFloat)getFloat:(NSString*)key fallback:(CGFloat)fallBack
{
    return [DKParser getFloat:self forKey:key fallback:fallBack];
}

- (long)getLong:(NSString*)key fallback:(long)fallBack
{
    return [DKParser getLong:self forKey:key fallback:fallBack];
}

- (SEL)getSelector:(NSDictionary*)d forKey:(NSString*)key fallback:(SEL)fallBack
{
    return [DKParser getSelector:self forKey:key fallback:fallBack];
}

@end
