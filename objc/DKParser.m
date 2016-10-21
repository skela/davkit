//
//  DKParser.m
//  DavKit
//
//  Created by Aleksander Slater on 09/06/2012.
//  Copyright (c) 2012 Davincium. All rights reserved.
//

#import "DKParser.h"

#import "UIColor+DavKit.h"
#import "NSDate+DavKit.h"
#import "NSString+DavKit.h"

@implementation DKParser

+ (id)getObject:(NSDictionary*)d ofClass:(Class)classe forKey:(NSString*)key fallback:(id)fallBack
{
    NSString *obj=[d objectForKey:key];
    if (obj!=nil && [obj isKindOfClass:classe])
        return obj;
    return fallBack;
}

+ (id)getObject:(NSDictionary*)d ofClass:(Class)classe forKeys:(NSArray*)keys fallback:(id)fallBack
{
    for (NSString *key in keys)
    {
        NSString *obj=[d objectForKey:key];
        if (obj!=nil && [obj isKindOfClass:classe])
            return obj;
    }
    return fallBack;
}

+ (NSValue*)getValue:(NSDictionary*)d forKey:(NSString*)key fallback:(NSValue*)fallBack
{
    return [DKParser getObject:d ofClass:[NSValue class] forKey:key fallback:fallBack];
}

+ (NSNumber*)getNumber:(NSDictionary*)d forKey:(NSString*)key fallback:(NSNumber*)fallBack
{
    return [DKParser getObject:d ofClass:[NSNumber class] forKey:key fallback:fallBack];
}

+ (NSString*)getString:(NSDictionary*)d forKey:(NSString*)key fallback:(NSString*)fallBack
{
    return [DKParser getObject:d ofClass:[NSString class] forKey:key fallback:fallBack];
}

+ (NSArray*)getArray:(NSDictionary*)d forKey:(NSString*)key fallback:(NSArray*)fallBack
{
    return [DKParser getObject:d ofClass:[NSArray class] forKey:key fallback:fallBack];    
}

+ (NSDictionary*)getDictionary:(NSDictionary*)d forKey:(NSString*)key fallback:(NSDictionary*)fallBack
{
    return [DKParser getObject:d ofClass:[NSDictionary class] forKey:key fallback:fallBack];        
}

+ (int)getInt:(NSDictionary*)d forKey:(NSString*)key fallback:(int)fallBack
{
    return [[DKParser getNumber:d forKey:key fallback:@(fallBack)] intValue];
}

+ (NSInteger)getInteger:(NSDictionary*)d forKey:(NSString*)key fallback:(NSInteger)fallBack
{
    return [[DKParser getNumber:d forKey:key fallback:@(fallBack)] integerValue];
}

+ (long long)getLongLong:(NSDictionary*)d forKey:(NSString*)key fallback:(long long)fallBack
{
    return [[DKParser getNumber:d forKey:key fallback:@(fallBack)] longLongValue];
}

+ (unsigned long long)getUnsignedLongLong:(NSDictionary*)d forKey:(NSString*)key fallback:(unsigned long long)fallBack
{
    return [[DKParser getNumber:d forKey:key fallback:@(fallBack)] unsignedLongLongValue];
}

+ (BOOL)getBool:(NSDictionary*)d forKey:(NSString*)key fallback:(BOOL)fallBack
{
    return [[DKParser getNumber:d forKey:key fallback:@(fallBack)] boolValue];
}

+ (double)getDouble:(NSDictionary*)d forKey:(NSString*)key fallback:(double)fallBack
{
    return [[DKParser getNumber:d forKey:key fallback:@(fallBack)] doubleValue];
}

+ (CGFloat)getFloat:(NSDictionary*)d forKey:(NSString*)key fallback:(CGFloat)fallBack
{
    return [[DKParser getNumber:d forKey:key fallback:@(fallBack)] floatValue];
}

+ (CGFloat)getCGFloat:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(CGFloat)fallBack
{
    return [[DKParser getNumber:d forKey:key fallback:@(fallBack)] floatValue];
}

+ (long)getLong:(NSDictionary*)d forKey:(NSString*)key fallback:(long)fallBack
{
    return [[DKParser getNumber:d forKey:key fallback:@(fallBack)] longValue];
}

+ (NSValue*)getValue:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSValue*)fallBack
{
    return [DKParser getObject:d ofClass:[NSValue class] forKeys:keys fallback:fallBack];
}

+ (NSNumber*)getNumber:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSNumber*)fallBack
{
    return [DKParser getObject:d ofClass:[NSNumber class] forKeys:keys fallback:fallBack];
}

+ (NSString*)getString:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSString*)fallBack
{
    return [DKParser getObject:d ofClass:[NSString class] forKeys:keys fallback:fallBack];
}

+ (NSArray*)getArray:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSArray*)fallBack
{
    return [DKParser getObject:d ofClass:[NSArray class] forKeys:keys fallback:fallBack];
}

+ (NSDictionary*)getDictionary:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSDictionary*)fallBack
{
    return [DKParser getObject:d ofClass:[NSDictionary class] forKeys:keys fallback:fallBack];
}

+ (NSInteger)getInteger:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSInteger)fallBack
{
    return [[DKParser getNumber:d forKeys:keys fallback:@(fallBack)] integerValue];
}

+ (int)getInt:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(int)fallBack
{
    return [[DKParser getNumber:d forKeys:keys fallback:@(fallBack)] intValue];
}

+ (long long)getLongLong:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(long long)fallBack
{
    return [[DKParser getNumber:d forKeys:keys fallback:@(fallBack)] longLongValue];
}

+ (BOOL)getBool:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(BOOL)fallBack
{
    return [[DKParser getNumber:d forKeys:keys fallback:@(fallBack)] boolValue];
}

+ (double)getDouble:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(double)fallBack
{
    return [[DKParser getNumber:d forKeys:keys fallback:@(fallBack)] doubleValue];
}

+ (CGFloat)getFloat:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(CGFloat)fallBack
{
    return [[DKParser getNumber:d forKeys:keys fallback:@(fallBack)] floatValue];
}

+ (long)getLong:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(long)fallBack
{
    return [[DKParser getNumber:d forKeys:keys fallback:@(fallBack)] longValue];
}

+ (SEL)getSelector:(NSDictionary*)d forKey:(NSString*)key fallback:(SEL)fallBack
{
    NSValue *obj=[d objectForKey:key];
    if (obj!=nil && [obj isKindOfClass:[NSValue class]])
    {
        SEL sel = [obj pointerValue];
        return sel;
    }
    else if (obj!=nil && [obj isKindOfClass:[NSString class]])
    {
        NSString *str = (NSString*)obj;
        SEL sel = NSSelectorFromString(str);
        return sel;
    }
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

+ (BOOL)isTrue:(id)o
{
    if ([o isKindOfClass:[NSString class]])
    {
        if ([o isEqualToString:@"1"])
            return YES;
        if ([[o lowercaseString] isEqualToString:@"true"])
            return YES;
    }
    if ([o isKindOfClass:[NSNumber class]])
    {
        NSInteger numb = [o integerValue];
        return numb;
    }
    return NO;
}

#pragma mark - Setters

+ (void)setObject:(id)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict fallback:(id)fallBack
{
    if (val==nil)
    {
        if (fallBack==nil)
        {
            [dict removeObjectForKey:key];
        }
        else
        {
            [dict setObject:fallBack forKey:key];
        }
    }
    else
    {
        [dict setObject:val forKey:key];
    }
}

+ (void)setNumber:(NSNumber*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:val forKey:key inDict:dict fallback:nil];
}

+ (void)setString:(NSString*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:val forKey:key inDict:dict fallback:nil];
}

+ (void)setDictionary:(NSDictionary*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:val forKey:key inDict:dict fallback:nil];
}

+ (void)setArray:(NSArray*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:val forKey:key inDict:dict fallback:nil];
}

+ (void)setInt:(int)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:[NSNumber numberWithInt:val] forKey:key inDict:dict fallback:nil];
}

+ (void)setInteger:(NSInteger)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:[NSNumber numberWithInteger:val] forKey:key inDict:dict fallback:nil];
}

+ (void)setLongLong:(long long)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:@(val) forKey:key inDict:dict fallback:nil];
}

+ (void)setUnsignedLongLong:(unsigned long long)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:@(val) forKey:key inDict:dict fallback:nil];
}

+ (void)setBool:(BOOL)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:[NSNumber numberWithBool:val] forKey:key inDict:dict fallback:nil];
}

+ (void)setSelector:(SEL)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:NSStringFromSelector(val) forKey:key inDict:dict fallback:nil];
}

#pragma mark - Containers

+ (NSInteger)addContentsOfDictInDict:(NSDictionary*)d withKey:(NSString*)key toDict:(NSMutableDictionary*)mdict
{
    NSDictionary *dict = [DKParser getDictionary:d forKey:key fallback:nil];
    if (dict!=nil)
    {
        [mdict addEntriesFromDictionary:dict];
    }
    return [dict count];
}

+ (NSInteger)addContentsOfArrayInDict:(NSDictionary*)d withKey:(NSString*)key toArray:(NSMutableArray*)mar
{
    NSArray *ar = [DKParser getArray:d forKey:key fallback:nil];
    if (ar!=nil)
    {
        [mar addObjectsFromArray:ar];
    }
    return [ar count];
}

#pragma mark - Special iOS and Mac

+ (void)setDate:(NSDate*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    if (val==nil)
        [DKParser setObject:val forKey:key inDict:dict fallback:nil];
    else
        [DKParser setObject:[NSNumber numberWithDouble:[val timeIntervalSince1970]]
                     forKey:key
                     inDict:dict
                   fallback:nil];
}

+ (void)setRect:(CGRect)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:NSStringFromCGRect(val) forKey:key inDict:dict fallback:nil];
}

+ (NSDate*)getDate:(NSDictionary*)d forKey:(NSString*)key fallback:(NSDate*)fallBack
{
    NSNumber *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSNumber class]])
        return [NSDate dateWithTimeIntervalSince1970:[n doubleValue]];
    if (n!=nil && [n isKindOfClass:[NSDate class]])
        return (NSDate*)n;
    return fallBack;
}

+ (CGRect)getRect:(NSDictionary*)d forKey:(NSString*)key fallback:(CGRect)fallBack
{
    NSString *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSString class]])
        return CGRectFromString(n);
    return fallBack;
}

+ (void)setDateId:(NSDate*)date withId:(NSString*)Id forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    if (date==nil || Id==nil)
        [self setString:nil forKey:key inDict:dict];
    else
        [self setDateId:[[DKDateId alloc] initWithDate:date andId:Id] forKey:key inDict:dict];
}

+ (void)setDateId:(DKDateId*)dateId forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [self setString:[dateId value] forKey:key inDict:dict];
}

+ (DKDateId*)getDateId:(NSDictionary*)d forKey:(NSString*)key fallback:(DKDateId*)fallBack
{
    NSString *s = [DKParser getString:d forKey:key fallback:nil];
    if (s!=nil)
    {
        DKDateId *dateId = [[DKDateId alloc] initWithString:s];
        if (dateId!=nil)
            return dateId;
    }
    return fallBack;
}

#pragma mark - Specials

+ (double)getDoubleFromString:(NSDictionary*)d forKey:(NSString*)key startsWith:(NSString*)start endsWith:(NSString*)end fallback:(double)fallBack
{
    NSString *s=[DKParser getString:d forKey:key fallback:nil];
    if (s!=nil)
    {
        if (start!=nil && end!=nil)
        {
            if ([s hasPrefix:start] && [s hasSuffix:end])
            {
                NSRange rstart = [s rangeOfString:start];
                NSRange rend = [s rangeOfString:end];
                NSRange res; res.location = rstart.location+rstart.length; res.length=rend.location-res.location;
                NSString *numString = [s substringWithRange:res];
                return [numString doubleValue];
            }
        }
    }
    return fallBack;
}

+ (double)getDoubleFromDotNetDateString:(NSDictionary*)d forKey:(NSString*)key fallback:(double)fallBack
{
    return [DKParser getDoubleFromString:d  forKey:key startsWith:@"/Date(" endsWith:@")/" fallback:fallBack];
}

+ (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

+ (NSDictionary*)getDictionaryFromUrl:(NSURL*)url
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *subString = [url query];
    NSArray *pairs = [subString componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs)
    {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =[[kv objectAtIndex:1] stringByReplacingPercentEscapes];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    NSDictionary *returnDict = [NSDictionary dictionaryWithDictionary:params];
    return returnDict;
}

#pragma mark - JSON

+ (id)fromJSONString:(NSString*)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [DKParser fromJSONData:data];
}

+ (id)fromJSONData:(NSData*)data
{
    if (data!=nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return json;
    }
    return nil;
}

+ (NSString*)toJSONString:(id)object
{
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    if (data!=nil)
    {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return str;
    }
    return nil;
}

+ (NSDictionary*)fromJSONToDictionary:(NSString*)jsonString
{
    return [DKParser fromJSONString:jsonString];
}

+ (NSArray*)fromJSONToArray:(NSString*)jsonString
{
    return [DKParser fromJSONString:jsonString];
}

+ (NSString*)fromDictionaryToJSON:(NSDictionary*)d
{
    return [DKParser toJSONString:d];
}

+ (NSString*)fromArrayToJSON:(NSArray*)d
{
    return [DKParser toJSONString:d];
}

+ (NSDictionary*)jsonSafeDictionary:(NSDictionary*)d
{
    if (d==nil) return nil;
    NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
    for (id key in d.allKeys)
    {
        id val = [d objectForKey:key];
        if ([val isKindOfClass:[NSDate class]])
        {
            [md setObject:@([((NSDate*)val) timeIntervalSince1970]) forKey:key];
        }
        else if ([val isKindOfClass:[UIColor class]])
        {
            [md setObject:[val hexRGBAString] forKey:key];
        }
        else if ([val isKindOfClass:NSClassFromString(@"DBList")])
        {
            [md setObject:[val values] forKey:key];
        }
        else
        {
            [md setObject:val forKey:key];
        }
    }
    return md;
}

+ (NSDictionary*)jsonSafeDictionaryISO:(NSDictionary*)d
{
    if (d==nil) return nil;
    NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
    for (id key in d.allKeys)
    {
        id val = [d objectForKey:key];
        if ([val isKindOfClass:[NSDate class]])
        {
            [md setObject:[val ISO8601String] forKey:key];
        }
        else if ([val isKindOfClass:[UIColor class]])
        {
            [md setObject:[val hexRGBAString] forKey:key];
        }
        else if ([val isKindOfClass:NSClassFromString(@"DBList")])
        {
            [md setObject:[val values] forKey:key];
        }
        else
        {
            [md setObject:val forKey:key];
        }
    }
    return md;
}

+ (NSDictionary*)convertDictValues:(NSDictionary*)d usingFormatters:(NSDictionary*)formatters
{
    if (formatters==nil || d==nil)
        return d;
    
    NSMutableDictionary *md = [[NSMutableDictionary alloc] initWithDictionary:d];
    for (id fkey in formatters.allKeys)
    {
        Class c = [d objectForKey:fkey];
        if ([NSDate class] == c)
        {
            NSDate *date = [DKParser getDate:md forKey:fkey fallback:nil];
            if (date!=nil)
            {
                [md setObject:date forKey:fkey];
            }
        }
    }
    return md;
}

@end

@implementation DKDateId

- (instancetype)initWithString:(NSString*)s
{
    self = [super init];
    if (self)
    {
        self.value = s;
    }
    
    if (self.Id!=nil && self.date!=nil)
        return self;
    return nil;
}

- (instancetype)initWithDate:(NSDate*)aDate andId:(NSString*)anId
{
    self = [super init];
    if (self)
    {
        [self setDate:aDate andId:anId];
    }
    return self;
}

- (void)setDate:(NSDate*)aDate andId:(NSString*)anId
{
    self.value = [NSString stringWithFormat:@"%f|%@",[aDate timeIntervalSince1970],anId];
}

- (NSArray*)components
{
    return [self.value componentsSeparatedByString:@"|"];
}

- (NSString*)Id
{
    NSArray *c = [self components];
    if (c.count==2)
    {
        return [c objectAtIndex:1];
    }
    return nil;
}

- (NSDate*)date
{
    NSArray *c = [self components];
    if (c.count==2)
    {
        NSString *c1 = [c firstObject];
        NSTimeInterval interval = [c1 doubleValue];
        return [NSDate dateWithTimeIntervalSince1970:interval];
    }
    return nil;
}

@end
