//
//  DKParser+UIKit.h
//  DavKit
//
//  Created by Aleksander Slater on 15/01/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "DKParser.h"

@interface DKParser (UIKit)

+ (UIColor*)getColor:(NSDictionary*)d forKey:(NSString*)key fallback:(UIColor*)fallBack;
+ (UIBezierPath*)getBezierPath:(NSDictionary*)d forKey:(NSString*)key fallback:(UIBezierPath*)fallBack;
+ (void)setColor:(UIColor*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setBezierPath:(UIBezierPath*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setImage:(UIImage*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (UIImage*)getImage:(NSDictionary*)d forKey:(NSString*)key fallback:(UIImage*)fallBack;
+ (CGPoint)getPoint:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(CGPoint)fallBack;
+ (CGPoint)getPoint:(NSDictionary*)d forKey:(NSString*)key fallback:(CGPoint)fallBack;
+ (void)setPoint:(CGPoint)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;

@end
