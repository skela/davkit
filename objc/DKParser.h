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

- (NSDictionary*)jsonSerialized;
+ (id)jsonDeserialize:(NSDictionary*)json;

@end

@interface DKParser : NSObject

+ (id)getObject:(NSDictionary*)d ofClass:(Class)classe forKey:(NSString*)key fallback:(id)fallBack;
+ (NSValue*)getValue:(NSDictionary*)d forKey:(NSString*)key fallback:(NSValue*)fallBack;
+ (NSNumber*)getNumber:(NSDictionary*)d forKey:(NSString*)key fallback:(NSNumber*)fallBack;
+ (NSString*)getString:(NSDictionary*)d forKey:(NSString*)key fallback:(NSString*)fallBack;
+ (NSInteger)getInteger:(NSDictionary*)d forKey:(NSString*)key fallback:(NSInteger)fallBack;
+ (int)getInt:(NSDictionary*)d forKey:(NSString*)keys fallback:(int)fallBack;
+ (BOOL)getBool:(NSDictionary*)d forKey:(NSString*)key fallback:(BOOL)fallBack;
+ (double)getDouble:(NSDictionary*)d forKey:(NSString*)key fallback:(double)fallBack;
+ (CGFloat)getFloat:(NSDictionary*)d forKey:(NSString*)key fallback:(CGFloat)fallBack;
+ (NSArray*)getArray:(NSDictionary*)d forKey:(NSString*)key fallback:(NSArray*)fallBack;
+ (NSDictionary*)getDictionary:(NSDictionary*)d forKey:(NSString*)key fallback:(NSDictionary*)fallBack;
+ (long)getLong:(NSDictionary*)d forKey:(NSString*)key fallback:(long)fallBack;
+ (long long)getLongLong:(NSDictionary*)d forKey:(NSString*)key fallback:(long long)fallBack;
+ (SEL)getSelector:(NSDictionary*)d forKey:(NSString*)key fallback:(SEL)fallBack;

+ (id)getObject:(NSDictionary*)d ofClass:(Class)classe forKeys:(NSArray*)keys fallback:(id)fallBack;
+ (NSValue*)getValue:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSValue*)fallBack;
+ (NSNumber*)getNumber:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSNumber*)fallBack;
+ (NSString*)getString:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSString*)fallBack;
+ (NSArray*)getArray:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSArray*)fallBack;
+ (NSDictionary*)getDictionary:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSDictionary*)fallBack;
+ (NSInteger)getInteger:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(NSInteger)fallBack;
+ (int)getInt:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(int)fallBack;
+ (long long)getLongLong:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(long long)fallBack;
+ (BOOL)getBool:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(BOOL)fallBack;
+ (double)getDouble:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(double)fallBack;
+ (CGFloat)getFloat:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(CGFloat)fallBack;
+ (long)getLong:(NSDictionary*)d forKeys:(NSArray*)keys fallback:(long)fallBack;

+ (BOOL)isDictionary:(id)d;
+ (BOOL)isNumber:(id)number;
+ (BOOL)isString:(id)string;
+ (BOOL)isArray:(id)ar;
+ (BOOL)isTrue:(id)o;

+ (void)setObject:(id)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict fallback:(id)fallBack;
+ (void)setString:(NSString*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setNumber:(NSNumber*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setDictionary:(NSDictionary*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setArray:(NSArray*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setInteger:(NSInteger)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setBool:(BOOL)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setSelector:(SEL)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setInt:(int)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;

+ (NSInteger)addContentsOfDictInDict:(NSDictionary*)d withKey:(NSString*)key toDict:(NSMutableDictionary*)mdict;
+ (NSInteger)addContentsOfArrayInDict:(NSDictionary*)d withKey:(NSString*)key toArray:(NSMutableArray*)mar;

+ (NSDate*)getDate:(NSDictionary*)d forKey:(NSString*)key fallback:(NSDate*)fallBack;
+ (CGRect)getRect:(NSDictionary*)d forKey:(NSString*)key fallback:(CGRect)fallBack;

+ (void)setDate:(NSDate*)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;
+ (void)setRect:(CGRect)val forKey:(NSString*)key inDict:(NSMutableDictionary*)dict;


// For example a normal string from .NET systems for timestamps could be: "/Date(1378151009864)/"
// In this case the inputs for this function would be startsWith:@"/Date(" endsWith:@")/"
+ (double)getDoubleFromString:(NSDictionary*)d
                       forKey:(NSString*)key
                   startsWith:(NSString*)start
                     endsWith:(NSString*)end
                     fallback:(double)fallBack;

+ (double)getDoubleFromDotNetDateString:(NSDictionary*)d forKey:(NSString*)key fallback:(double)fallBack;
+ (unsigned int)intFromHexString:(NSString *)hexStr;
+ (NSDictionary*)getDictionaryFromUrl:(NSURL*)url;

+ (id)fromJSONData:(NSData*)data;
+ (id)fromJSONString:(NSString*)jsonString;
+ (NSString*)toJSONString:(id)object;
+ (NSDictionary*)fromJSONToDictionary:(NSString*)jsonString;
+ (NSString*)fromDictionaryToJSON:(NSDictionary*)d;
+ (NSArray*)fromJSONToArray:(NSString*)jsonString;
+ (NSString*)fromArrayToJSON:(NSArray*)d;

@end
