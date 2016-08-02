//
//  NSDate+DavKit.h
//  Constructor
//
//  Created by Aleksander Slater on 18/06/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DavKit)

@property(readonly) BOOL isYesterday;
@property(readonly) BOOL isToday;
@property(readonly) BOOL isPast;
@property(readonly) BOOL isFuture;
@property(readonly) BOOL isPresent;

+ (NSDate*)yesterday;
+ (NSDate*)ereyesterday;
+ (NSDate*)tomorrow;
+ (NSDate*)overmorrow;
+ (NSDate*)lastWeek;

- (NSString*)ISO8601String;

@end
