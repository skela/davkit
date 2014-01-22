//
//  DKParser.h
//  DavKit
//
//  Created by Aleksander Slater on 09/06/2012.
//  Copyright (c) 2012 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DKJSON <NSObject>

- (NSDictionary*)jsonSerialized;
+ (id)jsonDeserialize:(NSDictionary*)json;

@end

@interface DKParser : NSObject

+ (id)getObject:(NSDictionary*)d ofClass:(Class)classe forKey:(NSString*)key fallBack:(id)fallBack;
+ (NSNumber*)getNumber:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSNumber*)fallBack;
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

+ (void)setObject:(id)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict fallBack:(id)fallBack;
+ (void)setString:(NSString*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setNumber:(NSNumber*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setDictionary:(NSDictionary*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setArray:(NSArray*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setInteger:(NSInteger)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;

+ (NSDate*)getDate:(NSDictionary*)d forKey:(NSString*)key fallBack:(NSDate*)fallBack;
+ (CGRect)getRect:(NSDictionary*)d forKey:(NSString*)key fallBack:(CGRect)fallBack;

+ (void)setDate:(NSDate*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setRect:(CGRect)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;


// For example a normal string from .NET systems for timestamps could be: "/Date(1378151009864)/"
// In this case the inputs for this function would be startsWith:@"/Date(" endsWith:@")/"
+ (double)getDoubleFromString:(NSDictionary*)d
                       forKey:(NSString*)key
                   startsWith:(NSString*)start
                     endsWith:(NSString*)end
                     fallBack:(double)fallBack;

+ (double)getDoubleFromDotNetDateString:(NSDictionary*)d forKey:(NSString*)key fallBack:(double)fallBack;
+ (unsigned int)intFromHexString:(NSString *)hexStr;
+ (NSDictionary*)getDictionaryFromUrl:(NSURL*)url;

@end
