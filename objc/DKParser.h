//
//  DKParser.h
//  DavKit
//
//  Created by Aleksander Slater on 09/06/2012.
//  Copyright (c) 2012 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DKJSON <NSObject>

- (nonnull NSDictionary*)jsonSerialized;
+ (nonnull id)jsonDeserialize:(nullable NSDictionary*)json;

@end

@interface DKParser : NSObject

+ (nullable id)getObject:(nullable NSDictionary*)d ofClass:(nonnull Class)classe forKey:(nonnull NSString*)key fallback:(nullable id)fallBack;
+ (nullable NSValue*)getValue:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable NSValue*)fallBack;
+ (nullable NSNumber*)getNumber:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable NSNumber*)fallBack;
+ (nullable NSString*)getString:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable NSString*)fallBack;
+ (NSInteger)getInteger:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(NSInteger)fallBack;
+ (int)getInt:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(int)fallBack;
+ (BOOL)getBool:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(BOOL)fallBack;
+ (double)getDouble:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(double)fallBack;
+ (CGFloat)getFloat:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(CGFloat)fallBack;
+ (nullable NSArray*)getArray:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable NSArray*)fallBack;
+ (nullable NSDictionary*)getDictionary:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable NSDictionary*)fallBack;
+ (long)getLong:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(long)fallBack;
+ (long long)getLongLong:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(long long)fallBack;
+ (nullable SEL)getSelector:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable SEL)fallBack;

+ (nullable id)getObject:(nullable NSDictionary*)d ofClass:(nonnull Class)classe forKeys:(nonnull NSArray*)keys fallback:(nullable id)fallBack;
+ (nullable NSValue*)getValue:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(nullable NSValue*)fallBack;
+ (nullable NSNumber*)getNumber:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(nullable NSNumber*)fallBack;
+ (nullable NSString*)getString:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(nullable NSString*)fallBack;
+ (nullable NSArray*)getArray:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(nullable NSArray*)fallBack;
+ (nullable NSDictionary*)getDictionary:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(nullable NSDictionary*)fallBack;
+ (NSInteger)getInteger:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(NSInteger)fallBack;
+ (int)getInt:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(int)fallBack;
+ (long long)getLongLong:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(long long)fallBack;
+ (BOOL)getBool:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(BOOL)fallBack;
+ (double)getDouble:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(double)fallBack;
+ (CGFloat)getFloat:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(CGFloat)fallBack;
+ (long)getLong:(nullable NSDictionary*)d forKeys:(nonnull NSArray*)keys fallback:(long)fallBack;

+ (BOOL)isDictionary:(nullable id)d;
+ (BOOL)isNumber:(nullable id)number;
+ (BOOL)isString:(nullable id)string;
+ (BOOL)isArray:(nullable id)ar;
+ (BOOL)isTrue:(nullable id)o;

+ (void)setObject:(nullable id)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict fallback:(nullable id)fallBack;
+ (void)setString:(nullable NSString*)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (void)setNumber:(nullable NSNumber*)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (void)setDictionary:(nullable NSDictionary*)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (void)setArray:(nullable NSArray*)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (void)setInteger:(NSInteger)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (void)setBool:(BOOL)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (void)setSelector:(nullable SEL)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (void)setInt:(int)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;

+ (NSInteger)addContentsOfDictInDict:(nullable NSDictionary*)d withKey:(nonnull NSString*)key toDict:(nullable NSMutableDictionary*)mdict;
+ (NSInteger)addContentsOfArrayInDict:(nullable NSDictionary*)d withKey:(nonnull NSString*)key toArray:(nullable NSMutableArray*)mar;

+ (nullable NSDate*)getDate:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(nullable NSDate*)fallBack;
+ (CGRect)getRect:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(CGRect)fallBack;

+ (void)setDate:(nullable NSDate*)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;
+ (void)setRect:(CGRect)val forKey:(nonnull NSString*)key inDict:(nullable NSMutableDictionary*)dict;


// For example a normal string from .NET systems for timestamps could be: "/Date(1378151009864)/"
// In this case the inputs for this function would be startsWith:@"/Date(" endsWith:@")/"
+ (double)getDoubleFromString:(nullable NSDictionary*)d
                       forKey:(nonnull NSString*)key
                   startsWith:(nonnull NSString*)start
                     endsWith:(nonnull NSString*)end
                     fallback:(double)fallBack;

+ (double)getDoubleFromDotNetDateString:(nullable NSDictionary*)d forKey:(nonnull NSString*)key fallback:(double)fallBack;
+ (unsigned int)intFromHexString:(nonnull NSString *)hexStr;
+ (nonnull NSDictionary*)getDictionaryFromUrl:(nullable NSURL*)url;

+ (nullable id)fromJSONData:(nullable NSData*)data;
+ (nullable id)fromJSONString:(nullable NSString*)jsonString;
+ (nullable NSString*)toJSONString:(nullable id)object;
+ (nullable NSDictionary*)fromJSONToDictionary:(nullable NSString*)jsonString;
+ (nullable NSString*)fromDictionaryToJSON:(nullable NSDictionary*)d;
+ (nullable NSArray*)fromJSONToArray:(nullable NSString*)jsonString;
+ (nullable NSString*)fromArrayToJSON:(nullable NSArray*)d;
+ (nullable NSDictionary*)jsonSafeDictionary:(nullable NSDictionary*)d;
+ (nullable NSDictionary*)convertDictValues:(nullable NSDictionary*)d usingFormatters:(nullable NSDictionary*)formatters;

@end
