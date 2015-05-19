//
//  NSDictionary+DavKit.h
//  Constructor
//
//  Created by Aleksander Slater on 17/12/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// These methods use DKParser internally.
// Please be aware, that its probably better to use DKParser directly instead of these,
// because if you use these methods here, the fallback may not always come out

@interface NSDictionary (DavKit)

- (NSValue*)getValue:(NSString*)key fallback:(NSValue*)fallBack;
- (NSNumber*)getNumber:(NSString*)key fallback:(NSNumber*)fallBack;
- (NSString*)getString:(NSString*)key fallback:(NSString*)fallBack;
- (NSArray*)getArray:(NSString*)key fallback:(NSArray*)fallBack;
- (NSDictionary*)getDictionary:(NSString*)key fallback:(NSDictionary*)fallBack;
- (NSInteger)getInteger:(NSString*)key fallback:(NSInteger)fallBack;
- (long long)getLongLong:(NSString*)key fallback:(long long)fallBack;
- (BOOL)getBool:(NSString*)key fallback:(BOOL)fallBack;
- (double)getDouble:(NSString*)key fallback:(double)fallBack;
- (CGFloat)getFloat:(NSString*)key fallback:(CGFloat)fallBack;
- (long)getLong:(NSString*)key fallback:(long)fallBack;
- (SEL)getSelector:(NSDictionary*)d forKey:(NSString*)key fallback:(SEL)fallBack;
- (NSString*)toJSON;

@end
