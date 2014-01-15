//
//  DKParser+UIKit.m
//  DavKit
//
//  Created by Aleksander Slater on 15/01/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "DKParser+UIKit.h"

@implementation DKParser (UIKit)

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

@end
