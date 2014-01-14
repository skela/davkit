//
//  DKParser.m
//  DAVKIT
//
//  Created by Aleksander Slater on 09/06/2012.
//  Copyright (c) 2012 Davincium. All rights reserved.
//

#import "DKParser.h"

@implementation DKParser

+ (id)getObject:(NSDictionary*)d ofClass:(Class)classe forKey:(NSString*)key fallBack:(id)fallBack
{
    NSString *obj=[d objectForKey:key];
    if (obj!=nil && [obj isKindOfClass:classe])
        return obj;
    return fallBack;
}

+ (NSString*)getString:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSString*)fallBack
{
    return [DKParser getObject:d ofClass:[NSString class] forKey:key fallBack:fallBack];
}

+ (NSArray*)getArray:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSArray*)fallBack
{
    return [DKParser getObject:d ofClass:[NSArray class] forKey:key fallBack:fallBack];    
}

+ (NSDictionary*)getDictionary:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSDictionary*)fallBack
{
    return [DKParser getObject:d ofClass:[NSDictionary class] forKey:key fallBack:fallBack];        
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

// Setters

+ (void)setObject:(id)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict fallBack:(id)fallBack
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

+ (void)setString:(NSString*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:val forKey:key inDict:dict fallBack:nil];
}

+ (void)setDictionary:(NSDictionary*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:val forKey:key inDict:dict fallBack:nil];
}

+ (void)setArray:(NSArray*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:val forKey:key inDict:dict fallBack:nil];
}

+ (void)setInt:(int)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:[NSNumber numberWithInt:val] forKey:key inDict:dict fallBack:nil];
}

+ (void)setInteger:(NSInteger)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:[NSNumber numberWithInteger:val] forKey:key inDict:dict fallBack:nil];
}

// Special iOS

+ (void)setDate:(NSDate*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    if (val==nil)
        [DKParser setObject:val forKey:key inDict:dict fallBack:nil];
    else
        [DKParser setObject:[NSNumber numberWithDouble:[val timeIntervalSince1970]]
                     forKey:key
                     inDict:dict
                   fallBack:nil];
}

+ (void)setRect:(CGRect)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setObject:NSStringFromCGRect(val) forKey:key inDict:dict fallBack:nil];
}

+ (void)setColor:(UIColor*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    NSString *color = [val hexRGBAString];
    [DKParser setObject:color forKey:key inDict:dict fallBack:nil];
}

void processPathElement (void *info, const CGPathElement *element)
{
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    
    CGPoint *points = element->points;
    
    CGPathElementType type = element->type;
    
    switch(type)
    {
        case kCGPathElementMoveToPoint: // contains 1 point
            [bezierPoints addObject:@{@"t":@"move_to",@"p0":NSStringFromCGPoint(points[0])}];
            break;
            
        case kCGPathElementAddLineToPoint: // contains 1 point
            [bezierPoints addObject:@{@"t":@"add_line",@"p0":NSStringFromCGPoint(points[0])}];
            break;
            
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [bezierPoints addObject:@{@"t":@"add_quad",@"p0":NSStringFromCGPoint(points[0]),@"p1":NSStringFromCGPoint(points[1])}];
            break;
            
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [bezierPoints addObject:@{@"t":@"add_curve",@"p0":NSStringFromCGPoint(points[0]),@"p1":NSStringFromCGPoint(points[1]),@"p2":NSStringFromCGPoint(points[2])}];
            break;
        
        case kCGPathElementCloseSubpath: // contains no point
            [bezierPoints addObject:@{@"t":@"close"}];
            break;
    }
}

+ (void)setBezierPath:(UIBezierPath*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    if (val==nil || ![val isKindOfClass:[UIBezierPath class]])
        [DKParser setObject:val forKey:key inDict:dict fallBack:nil];
    else
    {
        NSMutableArray *bezierPoints = [NSMutableArray array];
        CGPathApply(val.CGPath,(__bridge void *)bezierPoints,processPathElement);
        [DKParser setObject:bezierPoints forKey:key inDict:dict fallBack:nil];
    }
}

+ (NSDate*)getDate:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSDate*)fallBack
{
    NSNumber *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSNumber class]])
        return [NSDate dateWithTimeIntervalSince1970:[n doubleValue]];
    return fallBack;
}

+ (CGRect)getRect:(NSDictionary*)d forKey:(NSString*)key fallBack:(CGRect)fallBack
{
    NSString *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSString class]])
        return CGRectFromString(n);
    return fallBack;
}

+ (UIColor*)getColor:(NSDictionary*)d forKey:(NSString*)key fallBack:(UIColor*)fallBack
{
    NSString *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSString class]])
    {
        id val = [UIColor colorFromHexRGBAString:n];
        if (val!=nil && [val isKindOfClass:[UIColor class]])
            return val;
    }
    return fallBack;
}

+ (UIBezierPath*)getBezierPath:(NSDictionary*)d forKey:(NSString*)key fallBack:(UIBezierPath*)fallBack
{
    NSArray*ops = [DKParser getArray:d forKey:key fallBack:nil];
    if (ops!=nil && [ops isKindOfClass:[NSArray class]])
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint p0;
        CGPoint p1;
        CGPoint p2;
        for (NSDictionary*op in ops)
        {
            NSString *t = [DKParser getString:op forKey:@"t" fallBack:nil];
            NSString *sp0 = [DKParser getString:op forKey:@"p0" fallBack:nil];
            NSString *sp1 = [DKParser getString:op forKey:@"p1" fallBack:nil];
            NSString *sp2 = [DKParser getString:op forKey:@"p2" fallBack:nil];
            if ([t isEqualToString:@"move_to"] && sp0.length>0)
            {
                p0 = CGPointFromString(sp0);  // verified
                [path moveToPoint:p0];
            }
            else if ([t isEqualToString:@"add_line"] && sp0.length>0)
            {
                p0 = CGPointFromString(sp0);  // verified
                [path addLineToPoint:p0];
            }
            else if ([t isEqualToString:@"add_quad"] && sp0.length>0 && sp1.length>0)
            {
                p0 = CGPointFromString(sp1);  // NOTE: not sure about order here, might be wrong
                p1 = CGPointFromString(sp0);  // NOTE: not sure about order here, might be wrong
                [path addQuadCurveToPoint:p0 controlPoint:p1];
            }
            else if ([t isEqualToString:@"add_curve"] && sp0.length>0 && sp1.length>0 && sp2.length>0)
            {
                p0 = CGPointFromString(sp2); // verified
                p1 = CGPointFromString(sp0); // verified
                p2 = CGPointFromString(sp1); // verified
                [path addCurveToPoint:p0 controlPoint1:p1 controlPoint2:p2];
            }
            else if ([t isEqualToString:@"close"])
            {
                [path closePath];
            }
        }
        return path;
    }
    return fallBack;
}

// Specials

+ (double)getDoubleFromString:(NSDictionary*)d forKey:(NSString*)key startsWith:(NSString*)start endsWith:(NSString*)end fallBack:(double)fallBack
{
    NSString *s=[DKParser getString:d forKey:key fallBack:nil];
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

+ (double)getDoubleFromDotNetDateString:(NSDictionary*)d forKey:(NSString*)key fallBack:(double)fallBack
{
    return [DKParser getDoubleFromString:d  forKey:key startsWith:@"/Date(" endsWith:@")/" fallBack:fallBack];
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
        NSString *val =[[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    NSDictionary *returnDict = [NSDictionary dictionaryWithDictionary:params];
    return returnDict;
}

@end
