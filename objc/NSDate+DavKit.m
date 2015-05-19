//
//  NSDate+DavKit.m
//  Constructor
//
//  Created by Aleksander Slater on 18/06/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "NSDate+DavKit.h"

@implementation NSDate (DavKit)

- (BOOL)isToday
{
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    if([today day] == [otherDay day] && [today month] == [otherDay month] && [today year] == [otherDay year] && [today era] == [otherDay era])
    {
        return YES;
    }
    return NO;
}

- (BOOL)isYesterday
{
    NSTimeInterval interval = [self timeIntervalSince1970];
    NSDateComponents*comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate dateWithTimeIntervalSince1970:interval] toDate:[NSDate date] options:0];
	NSInteger val;
	val = [comps day];
	if (val==1)
        return YES;
    return NO;
}

- (BOOL)isPast
{
    return [self timeIntervalSinceNow]<0;
}

- (BOOL)isFuture
{
    return [self timeIntervalSinceNow]>0;
}

- (BOOL)isPresent
{
    return [self timeIntervalSinceNow]==0;
}

+ (NSDate*)yesterday
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]-86400];
}

+ (NSDate*)ereyesterday
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]-86400*2];
}

+ (NSDate*)tomorrow
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]+86400];
}

+ (NSDate*)overmorrow
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]+86400*2];
}

+ (NSDate*)lastWeek
{
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date]timeIntervalSince1970]-604800];
}

@end
