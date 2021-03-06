//
//  DKParser+UIKit.m
//  DavKit
//
//  Created by Aleksander Slater on 15/01/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "DKParser+UIKit.h"
#import <UIKit/UIKit.h>
#import "UIColor+DavKit.h"
#import "NSString+DavKit.h"
#import "NSData+DavKit.h"

@implementation DKParser (UIKit)

+ (void)setColor:(UIColor*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    if (val!=nil)
    {
        NSString *color = [val hexRGBAString];
        [DKParser setObject:color forKey:key inDict:dict fallback:nil];
    }
    else
    {
        [DKParser setObject:nil forKey:key inDict:dict fallback:nil];
    }
}

+ (void)setPoint:(CGPoint)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    NSString *point = NSStringFromCGPoint(val);
    [DKParser setObject:point forKey:key inDict:dict fallback:nil];
}

typedef enum
{
    BezierPathOperationMoveTo=1,
    BezierPathOperationAddLine=2,
    BezierPathOperationAddQuad=3,
    BezierPathOperationAddCurve=4,
    BezierPathOperationClose=5
} BezierPathOperation;

void processPathElement (void *info, const CGPathElement *element)
{
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    
    CGPoint *points = element->points;
    
    CGPathElementType type = element->type;
    
    switch(type)
    {
        case kCGPathElementMoveToPoint: // contains 1 point
            [bezierPoints addObject:@{@"t":@1,@"p0":NSStringFromCGPoint(points[0])}];
            break;
            
        case kCGPathElementAddLineToPoint: // contains 1 point
            [bezierPoints addObject:@{@"t":@2,@"p0":NSStringFromCGPoint(points[0])}];
            break;
            
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [bezierPoints addObject:@{@"t":@3,@"p0":NSStringFromCGPoint(points[0]),@"p1":NSStringFromCGPoint(points[1])}];
            break;
            
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [bezierPoints addObject:@{@"t":@4,@"p0":NSStringFromCGPoint(points[0]),@"p1":NSStringFromCGPoint(points[1]),@"p2":NSStringFromCGPoint(points[2])}];
            break;
            
        case kCGPathElementCloseSubpath: // contains no point
            [bezierPoints addObject:@{@"t":@5}];
            break;
    }
}

+ (void)setBezierPath:(UIBezierPath*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    if (val==nil || ![val isKindOfClass:[UIBezierPath class]])
        [DKParser setObject:val forKey:key inDict:dict fallback:nil];
    else
    {
        NSMutableArray *bezierPoints = [NSMutableArray array];
        CGPathApply(val.CGPath,(__bridge void *)bezierPoints,processPathElement);
        [DKParser setObject:bezierPoints forKey:key inDict:dict fallback:nil];
    }
}

+ (CGPoint)getPoint:(NSDictionary*)d forKey:(NSString*)key fallback:(CGPoint)fallBack
{
    return [DKParser getPoint:d forKeys:@[key] fallback:fallBack];
}

+ (CGPoint)getPoint:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(CGPoint)fallBack
{
    CGPoint p = fallBack;
    for (NSString *key in keys)
    {
        NSObject *obj = [d objectForKey:key];
        if ([obj isKindOfClass:[NSString class]])
        {
            NSString *s = ((NSString*)obj);
            if ([s hasPrefix:@"{"])
            {
                NSDictionary *jd = [DKParser fromJSONToDictionary:s];
                if (jd==nil)
                {
                    p = CGPointFromString(s);
                }
                else
                {
                    p.x = [DKParser getFloat:jd forKeys:@[@"x",@"a"] fallback:p.x];
                    p.y = [DKParser getFloat:jd forKeys:@[@"y",@"b"] fallback:p.y];
                }
            }
            else
            {
                p = CGPointFromString(s);
            }
        }
        else if ([obj isKindOfClass:[NSNumber class]])
        {
            if ([key isEqualToString:@"x"] || [key isEqualToString:@"a"])
            {
                p.x = [((NSNumber*)obj) floatValue];
            }
            else if ([key isEqualToString:@"y"] || [key isEqualToString:@"b"])
            {
                p.y = [((NSNumber*)obj) floatValue];
            }
        }
        else if ([obj isKindOfClass:[NSValue class]])
        {
            p = [((NSValue*)obj) CGPointValue];
        }
    }
    return p;
}

+ (UIColor*)getColor:(NSDictionary*)d forKey:(NSString*)key fallback:(UIColor*)fallBack
{
    id obj = [d objectForKey:key];
    if (obj!=nil && [obj isKindOfClass:[NSString class]])
    {
        NSString *n = (NSString*)obj;
        id val = [UIColor colorFromHexRGBOrRGBAString:n];
        if (val!=nil && [val isKindOfClass:[UIColor class]])
            return val;
    }
    if (obj!=nil && [obj isKindOfClass:[UIColor class]])
    {
        UIColor *clr = (UIColor*)obj;
        return clr;
    }
    return fallBack;
}

+ (UIColor*)getColor:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(UIColor*)fallBack
{
    for(NSString *key in keys)
    {
        UIColor *clr = [DKParser getColor:d forKey:key fallback:nil];
        if (clr!=nil) return clr;
    }
    return fallBack;
}

+ (void)setImage:(UIImage*)val withCompression:(CGFloat)compression forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    if (val==nil || ![val isKindOfClass:[UIImage class]])
        [DKParser setObject:val forKey:key inDict:dict fallback:nil];
    else
    {
        NSData *contentData = [NSData dataWithData:UIImageJPEGRepresentation(val,compression)];
        id content = [contentData encodedBase64String];
        [DKParser setObject:content forKey:key inDict:dict fallback:nil];
    }
}

+ (void)setImage:(UIImage*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict
{
    [DKParser setImage:val withCompression:0 forKey:key inDict:dict];
}

+ (UIImage*)getImage:(NSDictionary*)d forKey:(NSString*)key fallback:(UIImage*)fallBack
{
    NSString *n=[d objectForKey:key];
    if (n!=nil && [n isKindOfClass:[NSString class]])
    {
        NSData*data = [n stringToBase64EncodedData];
        id val = [UIImage imageWithData:data];
        if (val!=nil && [val isKindOfClass:[UIImage class]])
            return val;
    }
    return fallBack;
}

+ (UIBezierPath*)getBezierPath:(NSDictionary*)d forKey:(NSString*)key fallback:(UIBezierPath*)fallBack
{
    NSArray*ops = [DKParser getArray:d forKey:key fallback:nil];
    if (ops!=nil && [ops isKindOfClass:[NSArray class]])
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint p0;
        CGPoint p1;
        CGPoint p2;
        for (NSDictionary*op in ops)
        {
            NSNumber *t = [DKParser getNumber:op forKey:@"t" fallback:nil];
            NSString *sp0 = [DKParser getString:op forKey:@"p0" fallback:nil];
            NSString *sp1 = [DKParser getString:op forKey:@"p1" fallback:nil];
            NSString *sp2 = [DKParser getString:op forKey:@"p2" fallback:nil];
            if ([t integerValue]==BezierPathOperationMoveTo && sp0.length>0)
            {
                p0 = CGPointFromString(sp0);  // verified
                [path moveToPoint:p0];
            }
            else if ([t integerValue] == BezierPathOperationAddLine && sp0.length>0)
            {
                p0 = CGPointFromString(sp0);  // verified
                [path addLineToPoint:p0];
            }
            else if ([t integerValue] == BezierPathOperationAddQuad && sp0.length>0 && sp1.length>0)
            {
                p0 = CGPointFromString(sp1);  // NOTE: not sure about order here, might be wrong
                p1 = CGPointFromString(sp0);  // NOTE: not sure about order here, might be wrong
                [path addQuadCurveToPoint:p0 controlPoint:p1];
            }
            else if ([t integerValue] == BezierPathOperationAddCurve && sp0.length>0 && sp1.length>0 && sp2.length>0)
            {
                p0 = CGPointFromString(sp2); // verified
                p1 = CGPointFromString(sp0); // verified
                p2 = CGPointFromString(sp1); // verified
                [path addCurveToPoint:p0 controlPoint1:p1 controlPoint2:p2];
            }
            else if ([t integerValue] == BezierPathOperationClose)
            {
                [path closePath];
            }
        }
        return path;
    }
    return fallBack;
}

@end
