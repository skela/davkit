//
//  DKParser+UIKit.h
//  DavKit
//
//  Created by Aleksander Slater on 15/01/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "DKParser.h"

@interface DKParser (UIKit)

+ (nullable UIColor*)getColor:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable UIColor*)fallBack;
+ (void)setColor:(nullable UIColor*)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (nullable UIBezierPath*)getBezierPath:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable UIBezierPath*)fallBack;
+ (void)setBezierPath:(nullable UIBezierPath*)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (void)setImage:(nullable UIImage*)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (nullable UIImage*)getImage:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable UIImage*)fallBack;
+ (CGPoint)getPoint:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(CGPoint)fallBack;
+ (CGPoint)getPoint:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(CGPoint)fallBack;
+ (void)setPoint:(CGPoint)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
@end
