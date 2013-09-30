//
//  DKParser.h
//  DAVKIT
//
//  Created by Aleksander Slater on 09/06/2012.
//  Copyright (c) 2012 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKParser : NSObject

+ (id)getObject:(NSDictionary*)d ofClass:(Class)classe forKey:(NSString*)key fallBack:(id)fallBack;
+ (NSString*)getString:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSString*)fallBack;
+ (NSInteger)getInteger:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSInteger)fallBack;
+ (BOOL)getBool:(NSDictionary*)d forKey:(NSString*)key fallBack:(BOOL)fallBack;
+ (double)getDouble:(NSDictionary*)d forKey:(NSString*)key fallBack:(double)fallBack;
+ (CGFloat)getFloat:(NSDictionary*)d forKey:(NSString*)key fallBack:(CGFloat)fallBack;
+ (NSArray*)getArray:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSArray*)fallBack;
+ (NSDictionary*)getDictionary:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSDictionary*)fallBack;
+ (long)getLong:(NSDictionary*)d forKey:(NSString*)key fallBack:(long)fallBack;
+ (long long)getLongLong:(NSDictionary*)d forKey:(NSString*)key fallBack:(long long)fallBack;

+ (BOOL)isDictionary:(id)d;
+ (BOOL)isNumber:(id)number;
+ (BOOL)isString:(id)string;
+ (BOOL)isArray:(id)ar;

// For example a normal string from .NET systems for timestamps could be: "/Date(1378151009864)/"
// In this case the inputs for this function would be startsWith:@"/Date(" endsWith:@")/"
+ (double)getDoubleFromString:(NSDictionary*)d
                       forKey:(NSString*)key
                   startsWith:(NSString*)start
                     endsWith:(NSString*)end
                     fallBack:(double)fallBack;

+ (double)getDoubleFromDotNetDateString:(NSDictionary*)d forKey:(NSString*)key fallBack:(double)fallBack;

@end
