//
//  NSDate+DavKit.h
//  Constructor
//
//  Created by Aleksander Slater on 18/06/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DavKit)

- (BOOL)isYesterday;
- (BOOL)isToday;
- (BOOL)isPast;
- (BOOL)isFuture;
- (BOOL)isPresent;

+ (NSDate*)yesterday;
+ (NSDate*)ereyesterday;
+ (NSDate*)tomorrow;
+ (NSDate*)overmorrow;
+ (NSDate*)lastWeek;

@end
