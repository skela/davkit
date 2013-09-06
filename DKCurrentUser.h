//
//  DKCurrentUser.h
//  DAVKIT
//
//  Created by Aleksander Slater on 05/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKCurrentUser : NSObject

+ (void)clear;
+ (BOOL)sync;

+ (void)setBool:(BOOL)b withKey:(NSString*)key;
+ (BOOL)getBoolForKey:(NSString*)key defaultValue:(BOOL)def;
+ (void)setInteger:(NSInteger)i withKey:(NSString*)key;
+ (NSInteger)getIntegerForKey:(NSString*)key defaultValue:(NSInteger)def;
+ (NSArray*)getArrayForKey:(NSString*)key defaultValue:(NSArray*)def;
+ (void)setArray:(NSArray*)ar withKey:(NSString*)key;
+ (NSString*)getStringForKey:(NSString*)key defaultValue:(NSString*)def;
+ (void)setString:(NSString*)ar withKey:(NSString*)key;
+ (NSNumber*)getNumberForKey:(NSString*)key defaultValue:(NSNumber*)def;
+ (void)setNumber:(NSNumber*)ar withKey:(NSString*)key;
+ (BOOL)hasObjectWithKey:(NSString*)key;
+ (BOOL)hasStringWithKey:(NSString*)key;
+ (BOOL)hasArrayWithKey:(NSString*)key;
+ (BOOL)hasDictionaryWithKey:(NSString*)key;
+ (BOOL)hasNumberWithKey:(NSString*)key;
@end
