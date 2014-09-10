//
//  DKParser+UIKit.h
//  DavKit
//
//  Created by Aleksander Slater on 15/01/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "DKParser.h"

@interface DKParser (UIKit)

+ (UIColor*)getColor:(NSDictionary*)d forKey:(NSString*)key fallBack:(UIColor*)fallBack;
+ (UIBezierPath*)getBezierPath:(NSDictionary*)d forKey:(NSString*)key fallBack:(UIBezierPath*)fallBack;
+ (void)setColor:(UIColor*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setBezierPath:(UIBezierPath*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setImage:(UIImage*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (UIImage*)getImage:(NSDictionary*)d forKey:(NSString*)key fallBack:(UIImage*)fallBack;

@end
